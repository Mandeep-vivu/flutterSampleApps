import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  final String Email1;
 const ResetPasswordPage({Key? key,required this.Email1}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> _newPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmNewPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController confirmNewPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonUI(
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
        Form(
          key: _newPasswordFormKey,
          child: TextFormField(
            controller: newPasswordController,
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
              if (value != confirmNewPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ),
        const ResponsiveSizedBox(height: 21),
        Form(
          key: _confirmNewPasswordFormKey,
          child: TextFormField(
            controller: confirmNewPasswordController,
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
        const ResponsiveSizedBox(height: 20),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {
              final newPassword = newPasswordController.text;
              final confirmNewPassword = confirmNewPasswordController.text;
              print(newPassword);
              print(confirmNewPassword);
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              if (_newPasswordFormKey.currentState!.validate()) {

                authProvider.resetPassword(widget.Email1, newPassword,context);
              } else {
                // Show an error message that the passwords do not match
                print("je");
              }
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
