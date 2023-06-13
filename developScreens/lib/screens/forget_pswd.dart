import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:flutter/material.dart';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:provider/provider.dart';

class ForgetPas extends StatelessWidget {
  ForgetPas({Key? key}) : super(key: key);
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return CommonUI(
        children: [
          const LogoImage(),
          const ResponsiveSizedBox(
            height: 30,
          ),
          const HeadingWidget(
            text: 'Forgotten your password?',
          ),
          const ResponsiveSizedBox(
            height: 6,
          ),
          const HeadingWidget(
            text: 'Please enter your email',
            fontWeight: FontWeight.normal,
            color: Color(0xff626064),
            fontSize: 14,
          ),
          const ResponsiveSizedBox(
            height: 30,
          ),
          Form(
            key: _emailFormKey,
            child: TextFormField(
              controller: _mailController,
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
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          const ResponsiveSizedBox(
            height: 20,
          ),
          ResponsiveContainer(
            child: ElevatedButton(
              onPressed: () {
                if (_emailFormKey.currentState!.validate()) {
                  final email = _mailController.text;
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  authProvider.sendResetLink(email, context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF13131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const HeadingWidget(
                text: "Send Reset link",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    });
  }
}
