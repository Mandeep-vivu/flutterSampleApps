import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
              const ResponsiveSizedBox(
                height: 12,
              ),
              ResponsiveContainer(
                child: ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
