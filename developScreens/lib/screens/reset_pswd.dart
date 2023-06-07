import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      /*backButton:  Align(
        alignment: Alignment.topLeft,
        child: IconButton(onPressed: (){
          Navigator.pop(
            context,

          );
        },
          icon: const Icon(Icons.arrow_back),),
      ),*/
      children: [
        const LogoImage(),
        const ResponsiveSizedBox(
          height: 30,
        ),
        const HeadingWidget(
          text: 'Reset password?',
        ),
        const HeadingWidget(
          text: 'Please enter your new password',
          fontWeight: FontWeight.normal,
          color: Color(0xff626064),
          fontSize: 14,
        ),
        const ResponsiveSizedBox(
          height: 30,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'New Password',
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: const TextStyle(fontSize: 12),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your new password';
            }
            return null;
          },
        ),
        const ResponsiveSizedBox(height: 21),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Confirm New Password',
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: const TextStyle(fontSize: 12),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your new password';
            }
            return null;
          },
        ),
        const ResponsiveSizedBox(height: 20),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {
              // Handle password reset button tap
              // Check if both passwords are equal
              // If equal, proceed with password reset
              // If not equal, show an error message
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF13131),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const HeadingWidget(
                text: "Submit", color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
