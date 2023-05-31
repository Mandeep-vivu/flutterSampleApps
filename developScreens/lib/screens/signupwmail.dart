import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/screens/Smail.dart';
import 'package:developscreens/screens/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MailLogin extends StatefulWidget {
  const MailLogin({Key? key}) : super(key: key);

  @override
  State<MailLogin> createState() => _MailLoginState();
}

class _MailLoginState extends State<MailLogin> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    final textFormFieldHeight = screenSize.height * 0.06;
    return CommonUI(
          footer:Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have already account?',
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          color: Color(0xEDE51D23),
                          fontWeight: FontWeight.w700),
                      text: 'Sign in')),
            ),
          ],
        ),
      ) ,
          children: [
            const LogoImage(),
            const AutoFontSizeWidget(
              text:'Sign up',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: textFormFieldHeight,
              width: containerWidth,
              child: TextFormField(
                decoration: InputDecoration(
                  label: RichText(
                    text: const TextSpan(
                      text: "Name",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: " *", // Asterisk symbol
                          style: TextStyle(
                              color: Colors.red), // Red color
                        ),
                      ],
                    ),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon:
                      const Icon(Icons.person, color: Color(0xEDE51D23)),
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: containerWidth,
              height: textFormFieldHeight,
              child: TextFormField(
                decoration: InputDecoration(
                  label: RichText(
                    text: const TextSpan(
                      text: "Email",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: " *", // Asterisk symbol
                          style: TextStyle(
                              color: Colors.red), // Red color
                        ),
                      ],
                    ),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon:
                      const Icon(Icons.email, color: Color(0xEDE51D23)),
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: containerWidth,
              height: textFormFieldHeight,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  label: RichText(
                    text: const TextSpan(
                      text: "Password",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: " *", // Asterisk symbol
                          style: TextStyle(
                              color: Colors.red), // Red color
                        ),
                      ],
                    ),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: const Icon(Icons.remove_red_eye,
                      color: Color(0xEDE51D23)),
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors
                        .grey, // Checkbox border color when not selected
                  ),
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    visualDensity: VisualDensity.compact,
                    fillColor:
                        MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors
                            .red; // Checkbox fill color when selected
                      }
                      return Colors.grey;
                    }),
                  ),
                ),

                Container(
                  width: 250, // Adjust the width according to your needs
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'By clicking Create Account you agree to the ',
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Handle Terms and Conditions tap
                          },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Handle Privacy Policy tap
                            print("j");
                          },
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: textFormFieldHeight,
              width: double.infinity,
              child: ElevatedButton(

                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const VerificationPopup();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color(0xEDE51D23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AutoFontSizeWidget(
                    text:'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
    );
  }
}

class VerificationPopup extends StatelessWidget {
  const VerificationPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                color: Colors.red,
                height: 45,
                child: const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email Verification',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
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
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Thanks for signing up! we just need to verify your email address to complete the setting up your account.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue with Google button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MailDone()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                        0xFFF13131),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))
                ,
                ),
                child: const Text("Send link",style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
