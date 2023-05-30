import 'package:developscreens/commonUI.dart';
import 'package:developscreens/logoimage.dart';
import 'package:flutter/material.dart';

import 'ResetPas.dart';

class ForgetPas extends StatelessWidget {
  const ForgetPas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonUI(children:
    [
      const LogoImage(),
      const Text(
        'Forgotten your password?',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w600,
        ),
      ),
      const Text(
        'Please enter your email',
        style: TextStyle(
          fontSize: 16,

        ),
      ),
      const SizedBox(
        height: 40,
      ),
      SizedBox(
        child: TextFormField(
          decoration: InputDecoration(
            label: RichText(
              text: const TextSpan(
                text: "Email",
                style: TextStyle(color: Colors.grey),

              ),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),

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
      const SizedBox(height: 30),
      Container(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              // Handle continue with Google button tap
              /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
              );*/
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                  0xFFF13131),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))
              ,
            ),
            child: const Text("Send Reset link",style: TextStyle(color: Colors.white,fontSize: 19),)
        ),
      ),
      const SizedBox(height: 20),
    ]
    );
  }
}
