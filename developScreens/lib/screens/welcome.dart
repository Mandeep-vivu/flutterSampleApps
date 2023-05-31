import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/screens/signin.dart';
import 'package:developscreens/screens/signupwmail.dart';
import 'package:developscreens/screens/signupwmob.dart';
import 'package:flutter/material.dart';
import 'package:developscreens/commonUI.dart';
class WelcomeS extends StatelessWidget {
  const WelcomeS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      footer:  Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AutoFontSizeWidget(
              style: TextStyle(fontSize: 14), text: 'You have already account?'
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
      ),
      children: [
        const SizedBox(height: 10,),
        const Text(
          'Welcome to App',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const LogoImage(),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MobileLog()),
                  );

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xEDE51D23),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: AutoFontSizeWidget(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ), text: 'Continue with Phone',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle continue with Google button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MailLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xEDDB4437),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: ListTile(
                  leading: Image.asset('assets/google.png'),
                  title: AutoFontSizeWidget(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ), text: 'Continue with Google',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle continue with Google button tap
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B5998),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: ListTile(
                  leading: Image.asset('assets/facebook.png'),
                  title: AutoFontSizeWidget(
                    text: 'Continue with Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),

      ],
    );
  }
}
