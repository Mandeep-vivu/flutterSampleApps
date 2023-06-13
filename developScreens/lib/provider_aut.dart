import 'dart:convert';
import 'package:developscreens/messenger/homepage.dart';
import 'package:developscreens/screens/otp_on_phn.dart';
import 'package:developscreens/screens/reset_pswd.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  // User Data
  late String _username;

  late String _profilePicture;
  String baseUrl = 'http://139.59.47.49:4001/user';
late String token;
  bool _isLoggedIn = false;

  // Error Handling
  String? _error;

  // Loading State
  bool _isLoading = false;


  Future<void> logoutUser(BuildContext context) async {
    final url = Uri.parse('$baseUrl/logout');

    try {
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('logout successfully'),
          ),
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeS()), (route) => false);
      } else {
        // Failed to log out
        // Handle the error accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('try again'),
          ),
        );
      }
    } catch (e) {
      // An error occurred while logging out
      // Handle the error accordingly
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

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {

      final responseData = json.decode(response.body);
      if (responseData.containsKey('access_token') &&
          responseData.containsKey('user_id')) {
        final accessToken = responseData['access_token'];
        /*final userId = responseData['user_id'];*/

        print('Token received: $accessToken');
        token=accessToken;
        print(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePa(),
          ),
        );
      }  else {
        final responseData = json.decode(response.body);
        final type = responseData['type'];

        if (type == 'user_not_exists') {
          print('This email is not registered');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('This email is not registered'),
            ),
          );
        } else if (type == 'invalid_password') {
          print('Incorrect password entered');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect password entered'),
            ),
          );
        } else {
          print('Unexpected response: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unexpected response'),
            ),
          );
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Request failed with status: ${response.statusCode}'),
        ),
      );
    }
  }
  Future<void> signUp(
    String name,
    String email,
    String phoneNo,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/signup/phone');
    final body = {
      'name': name,
      'email': email,
      'phone_no': phoneNo,
      'password': password,
    };
    final response = await http.post(url, body: body);
    try {
      if (response.statusCode == 200) {
        _isLoggedIn = true;
        print(body);
      } else {
        _error = 'Sign up failed. Please try again.';
        _isLoggedIn = false;
      }
    } catch (error) {
      _error = 'An error occurred. Please try again later.';
      _isLoggedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }



  Future<void> sendResetLink(String email, BuildContext context) async {
    final url = '$baseUrl/forget-password';
_resemail=email;
    final body = json.encode({'email': email});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body=="reset otp sent successfuly") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpVerify(email: email)),
          );
        }
        else{
          final responseData = json.decode(response.body);
          final type = responseData['type'];

          if (type == 'user_not_exists') {
            print('This email is not registered');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('This email is not registered'),
              ),
            );
        }}
      } else {
        print('Failed to send reset link. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending reset link: $e');
    }
  }



  Future<bool> verifyOTP(String email, int otp, BuildContext context,button) async {
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
            MaterialPageRoute(builder: (context) => ResetPasswordPage(Email1: email)),
          );
        } else {
          // Handle other responses (if any)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
          button=!button;
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

        // Handle specific error scenarios
        if (statusCode == 400 && customMessage == "Invalid OTP") {
          print("Invalid OTP");

        } else {
          // Handle other error scenarios
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
          print("Unexpected error response: $errorBody");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid OTP"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Failed to decode error response: $e");
      }
    } else {
      // Handle other scenarios, such as network errors

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
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } else {}
  }
late String _resemail;
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String get email => _resemail;
  String get profilePicture => _profilePicture;
  String? get error => _error;
  bool get isLoading => _isLoading;
}
