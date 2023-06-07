import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:developscreens/screens/signup_mail.dart';
import 'package:developscreens/screens/signup_mobile.dart';
import 'package:flutter/material.dart';
import 'package:developscreens/commons/comn_ui.dart';

class WelcomeS extends StatelessWidget {
  const WelcomeS({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CommonUI(
        footer: Row(
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
                  MaterialPageRoute(builder: (context) =>  LoginPage()),
                );
              },
              child: RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          color: Color(0xEDE51B23),
                          fontSize: 14,
                          fontWeight: FontWeight.w800),
                      text: 'Sign in')),
            ),
          ],
        ),
        children: [
          const HeadingWidget(
            text: 'Welcome to App',
            fontSize: 27,
          ),
          const ResponsiveSizedBox(),
          const LogoImage(),
          const ResponsiveSizedBox(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ResponsiveContainer(
                child: ElevatedButton(
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
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      HeadingWidget(
                        text: 'Continue with Phone',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const ResponsiveSizedBox(
                height: 12,
              ),
              ResponsiveContainer(
                child: ElevatedButton(
                    onPressed: () {
                      // Handle continue with Google button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MailLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xEDDB4437),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: Image.asset('assets/google.png'),
                        ),
                        const HeadingWidget(
                          text: 'Continue with Google',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
              const ResponsiveSizedBox(
                height: 12,
              ),
              ResponsiveContainer(
                child: ElevatedButton(
                    onPressed: () {
                      // Handle continue with Google button tap
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B5998),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                          child: Image.asset('assets/facebook.png'),
                        ),
                        const HeadingWidget(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                          text: 'Continue with Facebook',
                        ),
                      ],
                    )
                    /*ListTile(
                    leading: ,
                    title: const
                  ),*/
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
