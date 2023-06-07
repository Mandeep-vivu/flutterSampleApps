import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/mail_verified.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailLogin extends StatefulWidget {
  const MailLogin({Key? key}) : super(key: key);

  @override
  State<MailLogin> createState() => _MailLoginState();
}

class _MailLoginState extends State<MailLogin> {
  bool isChecked = false;
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mobileformKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  late bool _passwordVisible;
//mobile
  late String mobileNumber;
  bool isNumberInputActive = false;
  String dialCode = '+91';
  late int phLength;
  late TextInputFormatter mobileNumberInputFormatter;
  late String _countryname;
  void _clearMobileNumberField() {
    _mobileNumberController.text = '';
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _countryname = "India";
    dialCode = '91';
    phLength = 10;
    mobileNumberInputFormatter = LengthLimitingTextInputFormatter(phLength);
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final scaleFactor = screenWidth / 375; // 375 is the reference screen width
    final desiredFontSize = 14 * scaleFactor;
    Widget doneButton = Container();
    if (Platform.isIOS && isNumberInputActive) {
      doneButton = IconButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
        },
        icon: const Icon(Icons.done),
      );
    }
    return CommonUI(
      footer: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeadingWidget(
              text: 'You have already account?',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xFF3B3838),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: const Color(0xEDE51B23),
                          fontSize: 14 * scaleFactor,
                          fontWeight: FontWeight.w800),
                      text: 'Sign in')),
            ),
          ],
        ),
      ),
      children: [
        const LogoImage(),
        const ResponsiveSizedBox(
          height: 30,
        ),
        const HeadingWidget(
          text: 'Sign up',
        ),
        const ResponsiveSizedBox(
          height: 25,
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 12 * scaleFactor),
            label: RichText(
              text: const TextSpan(
                text: "Name",
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: " *", // Asterisk symbol
                    style: TextStyle(color: Colors.red), // Red color
                  ),
                ],
              ),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: const Icon(Icons.person, color: Color(0xEDE51D23)),
          ),
          style: const TextStyle(fontSize: 12),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const ResponsiveSizedBox(
          height: 17,
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 12 * scaleFactor),
            label: Text(
              "Last name",
              style: TextStyle(color: Colors.grey),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: const TextStyle(fontSize: 12),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const ResponsiveSizedBox(height: 17),
        Form(
          key: _emailFormKey,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _mailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12 * scaleFactor), // Adjust the padding as needed
              label: RichText(
                text: const TextSpan(
                  text: "Email",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: " *", // Asterisk symbol
                      style: TextStyle(color: Colors.red), // Red color
                    ),
                  ],
                ),
              ),
              labelStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: const Icon(Icons.email, color: Color(0xEDE51D23)),
            ),
            autofocus: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),
        const ResponsiveSizedBox(height: 17),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xffBEBEBE)),
              left: BorderSide(color: Color(0xffBEBEBE)),
              right: BorderSide(color: Color(0xffBEBEBE)),
              bottom: BorderSide(color: Color(0xffBEBEBE)),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Color(0xffBEBEBE)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ResponsiveSizedBox(
                      height: 9,
                    ),
                    const HeadingWidget(
                      text: "Country/Region",
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _countryname = country.name;
                              _clearMobileNumberField(); // Clear the mobile number field when a new country is selected
                              dialCode = country.phoneCode;
                              phLength = country.example.length;
                              mobileNumberInputFormatter =
                                  LengthLimitingTextInputFormatter(phLength);
                            });
                          },
                        );
                      },
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          children: [
                            Text(
                              "(+$dialCode)",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff000000),
                              ),
                            ),
                            const Align(
                                child: Icon(Icons.arrow_drop_down_sharp)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [const ResponsiveSizedBox(
                    height: 9,
                  ),
                    const HeadingWidget(
                      text: " Mobile Number",
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 150,
                      height: 44,
                      child: Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _mobileformKey,
                              child: TextFormField(
                                controller: _mobileNumberController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  mobileNumberInputFormatter
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    isNumberInputActive = value.isNotEmpty;
                                  });
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(3, 1, 0, 12.6)),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your mobile number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const ResponsiveSizedBox(height: 17),
        Form(
          key: _passwordFormKey,
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              label: RichText(
                text: const TextSpan(
                  text: "Password",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              labelStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon: /*const IconButton(Icons.remove_red_eye, color: Color(0xEDE51D23)),*/
                  IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xEDE51D23),
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }

              if (!RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
                  .hasMatch(value)) {
                return 'Password must contain at least one uppercase \nletter, one lowercase letter, one digit, and one \nspecial character';
              }

              return null;
            },
          ),
        ),
        const ResponsiveSizedBox(
          height: 22,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor:
                      Colors.grey, // Checkbox border color when not selected
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                  child: Checkbox(
                    shape: const ContinuousRectangleBorder(),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    visualDensity: VisualDensity.compact,
                    fillColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.red; // Checkbox fill color when selected
                      }
                      return Colors.grey;
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(
              width:
                  258 * scaleFactor, // Adjust the width according to your needs
              child: RichText(
                text: TextSpan(
                  text: 'By clicking Create Account you agree to the ',
                  style: TextStyle(
                      fontSize: desiredFontSize,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'OpenSans'),
                  children: [
                    TextSpan(
                      text: 'Terms of service',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: desiredFontSize,
                        fontFamily: 'OpenSans',
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms and Conditions tap
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: desiredFontSize,
                        fontFamily: 'OpenSans',
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy tap
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const ResponsiveSizedBox(height: 23),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: isChecked ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xEDE51D23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const HeadingWidget(
                text: 'Continue', color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_emailFormKey.currentState!.validate() &&
        _passwordFormKey.currentState!.validate()) {
      // Forms are valid, continue with further actions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const VerificationPopup();
        },
      );
    }
  }
}

class VerificationPopup extends StatelessWidget {
  const VerificationPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final scaleFactor = screenWidth / 375;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(20)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20)),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.red),
                        height: 45 * scaleFactor,
                        width: screenWidth * 1.2,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeadingWidget(
                              text: 'Email Verification',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const ResponsiveSizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: HeadingWidget(
                  text:
                      'Thanks for signing up ! we just\nneed to verify your email address to complete to setting up your account',
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
              const ResponsiveSizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ResponsiveContainer(
                  child: ElevatedButton(
                      onPressed: () {
                        // Handle continue with Google button tap
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MailDone()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF13131),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const HeadingWidget(
                        text: "Send link",
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
              ),
              const ResponsiveSizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
