import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.06; // Adjust the multiplier as needed
    final textFormFieldHeight = screenSize.height * 0.06; // Adjust the multiplier as needed
    final sizedBoxHeight = screenSize.height * 0.03; // Adjust the multiplier as needed

    return CommonUI(
      backButton:  Align(
        alignment: Alignment.topLeft,
        child: IconButton(onPressed: (){
          Navigator.pop(
            context,

          );
        },
          icon: const Icon(Icons.arrow_back),),
      ),
      children: [
        const LogoImage(),
        const Text(
          'Reset password?',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        const AutoFontSizeWidget(
          text: 'Please enter your new password',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),
        SizedBox(
          height: textFormFieldHeight,
          child: TextFormField(
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
        ),
        SizedBox(height: sizedBoxHeight),
        SizedBox(
          height: textFormFieldHeight,
          child: TextFormField(
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
        ),
        SizedBox(height: sizedBoxHeight),
        Container(
          height: buttonHeight,
          width: double.infinity,
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
            child: AutoFontSizeWidget(
              text:"Submit",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        SizedBox(height: sizedBoxHeight),
      ],
    );
  }
}
