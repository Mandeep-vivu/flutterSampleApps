import 'package:flutter/material.dart';
import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'ResetPas.dart';

class ForgetPas extends StatelessWidget {
  const ForgetPas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.06;
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
        LogoImage(),
        const AutoFontSizeWidget(
          text: 'Forgotten your password?',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        AutoFontSizeWidget(
          text:'Please enter your email',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: buttonHeight,
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
        SizedBox(height: 30),
        Container(
          height: buttonHeight,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF13131),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: AutoFontSizeWidget(
              text:"Send Reset link",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
