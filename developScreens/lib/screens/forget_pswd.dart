import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'reset_pswd.dart';

class ForgetPas extends StatelessWidget {
  const ForgetPas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CommonUI(
      /* backButton:  Align(
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
        const ResponsiveSizedBox(
          height: 20,
        ),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage()),
              );
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
  }
}
