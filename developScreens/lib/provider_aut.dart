import 'dart:convert';
import 'dart:io';
import 'package:developscreens/messenger/homepage.dart';
import 'package:developscreens/screens/mail_verified.dart';
import 'package:developscreens/screens/otp_on_phn.dart';
import 'package:developscreens/screens/reset_pswd.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:developscreens/screens/signup_mail.dart';
import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'messenger/models/chatmodel.dart';

class AuthProvider with ChangeNotifier {

  // User Data
  late String _username;
  late String _lusername;
  late String _emailid;

  String baseUrl = 'http://139.59.47.49:4001/user';
  late String token;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  late String userId;
  List<dynamic> data1 = [];
  late String mobilenum;
  String get mobnumber => mobilenum;
  late String _resemail;
  late String profileimg;
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String get lusername => _lusername;
  String get personids => userId;
  String get email => _resemail;
  String get emailid=>_emailid;
  String get profilePicture => profileimg;
  List<dynamic> get data => data1;
  bool get isLoading => _isLoading;



  Future<void> logoutUser(BuildContext context) async {
    final url = Uri.parse('$baseUrl/logout');
    try {
      final response = await http.delete(
        url,
        headers: {'token': '$token'},
      );
      if (response.statusCode == 200) {
        print("-----${response.body}");
        token="";
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xc3f55a50),
            margin: EdgeInsets.fromLTRB(40, 0, 40, 620),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            content: Text('logout successfully'),
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeS()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xc3f55a50),
            margin: EdgeInsets.fromLTRB(40, 0, 40, 620),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            content: Text('try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: const Color(0xc3f55a50),
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 80),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          content: Text('$e'),
        ),
      );
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'user_email': email,
      'user_password': password,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData.containsKey('access_token') &&
            responseData.containsKey('_id')) {
          final accessToken = responseData['access_token'];
          userId = responseData['_id'];
          profileimg = responseData['profile_pic'] ?? '';
          final fname = responseData['first_name'];
          final lname = responseData['last_name'] ?? '';
          _username = fname;
          _lusername=lname;
          mobilenum=responseData['phone_no'].toString();
          token = accessToken;
          _emailid=responseData['email'];
          notifyListeners();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePa(
                token: token,
                userId: userId,
              ),
            ),
          );
        } else {
          final type = responseData['type'];
          if (type == 'user_not_exists') {
            showSnackBar(context, 'Email not registered');
          } else if (type == 'invalid_password') {
            showSnackBar(context, 'Incorrect password entered');
          } else {
            showSnackBar(context, 'Unexpected response');
          }
        }
      } else {
        showSnackBar(
            context, 'Request failed with status: ${response.statusCode}');
      }
    } on SocketException {
      showSnackBar(context, 'Network error');
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }



  Future<void> signUp(
    String name,
    String lname,
    String email,
    String phoneNo,
    String password,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('$baseUrl/signup/phone');
    final body = {
      'first_name': name,
      'last_name': lname,
      'email': email,
      'phone_no': phoneNo,
      'password': password,
    };
    _resemail = email;
    final response = await http.post(url, body: body);
    try {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData.containsKey('access_token') &&
            responseData.containsKey('user_id')) {
          final accessToken = responseData['access_token'];
          print('Token received: $accessToken');
          token = accessToken;
          showSnackBar(context, 'Signup Successfully');
          print(response.body);
          _isLoggedIn = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const VerificationPopup();
            },
          );
          print(body);
        } else if (responseData.containsKey('status_code') &&
            responseData.containsKey('custom_msg')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['custom_msg']),
              duration: const Duration(seconds: 1),
              backgroundColor: const Color(0xdbf55a60),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (responseData.containsKey('code')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed! use different mobile number"),
              duration: Duration(seconds: 1),
              backgroundColor: Color(0xdbf55a60),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
            ),
          );
          print(responseData['code']);
        }
      } else {
        showSnackBar(context, 'Sign up failed. Please try again.');
        _isLoggedIn = false;
      }
    } catch (error) {
      showSnackBar(context, 'An error occurred. Please try again later.');
      _isLoggedIn = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendVerifyEmail(BuildContext context) async {
    final url = Uri.parse('$baseUrl/resend-email-otp');
    print(token);
    try {
      final response = await http.get(
        url,
        headers: {'accept': '*/*', 'token': '$token'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == 'succefully send otp') {}
      } else {
        final responseData = json.decode(response.body);
        print("$responseData");
        showSnackBar(context, 'error sending Otp');
      }
    } catch (e) {
      print('Error sending reset Otp: $e');
    }
  }

  Future<void> sendResetLink(String email, BuildContext context) async {
    final url = '$baseUrl/forget-password';
    _resemail = email;
    final body = json.encode({'email': email});
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "reset otp sent successfuly") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpVerify(email: email)),
          );
        } else {
          final responseData = json.decode(response.body);
          final type = responseData['type'];
          if (type == 'user_not_exists') {
            print('This email is not registered');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('This email is not registered'),
              ),
            );
          }
        }
      } else {
        print('Failed to send reset link. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending reset link: $e');
    }
  }

  Future<bool> verifyMOTP(int otp, BuildContext context, button) async {
    final url = '$baseUrl/verfiy-email';

    final body = json.encode({
      'otp': otp,
    });

    String responseBody;
    String? errorBody;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'token': '$token',
          'Content-Type': 'application/json'
        },
        body: body,
      );

      if (response.statusCode == 200) {
        responseBody = response.body;
        final responseData = json.decode(response.body);
        print(responseData['is_email_verfied']);
        if (responseData['is_email_verfied'] == true) {
          // Handle OTP verification success
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MailDone()),
          );
        } else {
          // Handle other responses (if any)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
          button = !button;
          print("Unexpected response body: $responseBody");
        }
      } else {
        errorBody = response.body;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
    }

    if (errorBody != null) {
      // Handle error response
      try {
        final errorResponse = json.decode(errorBody);
        final statusCode = errorResponse['status_code'];
        final customMessage = errorResponse['custom_msg'];
        if (statusCode == 400 && customMessage == "OTP not verified") {
          print("Invalid OTP");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("either invalid otp or expired"),
              backgroundColor: Colors.red,
            ),
          );
          print("Unexpected error response: $errorBody");
        }
      } catch (e) {
        print("Failed to decode error response: $e");
      }
    }
    return button;
  }

  Future<bool> verifyOTP(
      String email, int otp, BuildContext context, button) async {
    final url = '$baseUrl/otp-verification';
    final body = json.encode({
      'email': email,
      'otp': otp,
    });

    String responseBody;
    String? errorBody;

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        responseBody = response.body;

        // Check if the OTP is verified
        if (responseBody == "your otp is verifiyed") {
          // Handle OTP verification success
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordPage(Email1: email)),
          );
        } else {
          // Handle other responses (if any)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
          button = !button;
          print("Unexpected response body: $responseBody");
        }
      } else {
        errorBody = response.body;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
    }

    if (errorBody != null) {
      try {
        final errorResponse = json.decode(errorBody);
        final statusCode = errorResponse['status_code'];
        final customMessage = errorResponse['custom_msg'];
        if (statusCode == 400 && customMessage == "Invalid OTP") {
          print("Invalid OTP");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
          print("Unexpected error response: $errorBody");
        }
      } catch (e) {
        print("Failed to decode error response: $e");
      }
    }
    return button;
  }

  Future<void> resetPassword(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/reset-password');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final headers = {'Content-Type': 'application/json'};

    final response = await http.put(url, headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } else {}
  }

  Future<void> sendprofilepic() async {
    var url = Uri.parse('$baseUrl/profile-pic');
    var headers = {
      'token': token,
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({'profile_pic': profileimg});

    var response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);

    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }
  Future<void> namechange(firstname,lastname) async {
    var url = Uri.parse('$baseUrl/');
    var headers = {
      'token': token,
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "user_id": userId,
      "first_name": firstname,
      "last_name": lastname,
      "email": emailid
    });

    var response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      _username=firstname;
      _lusername=lastname;
      var mdmr=json.decode(response.body);
      print(mdmr);

    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }

  Future<void> selectContact() async {
    final response = await http.get(
      Uri.parse('http://139.59.47.49:4001/user'),
      headers: {
        'accept': '*/*',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      data1 = json.decode(response.body);
    } else {
      // Handle API error
      print('API error: ${response.statusCode}');
    }
  }

  String? getImageType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'jpeg';
      case 'png':
        return 'png';
      case 'gif':
        return 'gif';
      // Add more cases for additional image types as needed
      default:
        return null;
    }
  }



  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse('$baseUrl/image_upload');
    final request = http.MultipartRequest('POST', url);
    request.headers['accept'] = '*/*';
    request.headers['token'] = token;

    var imageExtension = imageFile.path.split('.').last;
    var imageType = getImageType(imageExtension);

    if (imageType != null) {
      var image = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', imageType),
      );
      request.files.add(image);
    }
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final parsedResponse = json.decode(responseBody);
      print('Parsed response: $parsedResponse');
      var imageurls = parsedResponse['image_url'];
      profileimg = imageurls;
    } else {
      // Error uploading image
      print('Image upload failed with status: ${response.statusCode}');
    }
  }
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xc3f55a50),
        margin: const EdgeInsets.fromLTRB(40, 0, 40, 80),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


}
