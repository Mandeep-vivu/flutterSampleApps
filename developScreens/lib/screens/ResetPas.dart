import 'package:developscreens/commonUI.dart';
import 'package:developscreens/logoimage.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonUI(
      children: [
        const LogoImage(),
        const Text(
          'Reset password?',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'Please enter your new password',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
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
        const SizedBox(height: 30),
        SizedBox(
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
        const SizedBox(height: 30),
        Container(
          height: 55,
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
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
