import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/screens/welcome.dart';
import 'package:flutter/material.dart';

import 'Sphn.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}


class _OtpVerifyState extends State<OtpVerify> {
  void _checkOtpCode() {
    String otpCode = '';
    for (var controller in _controllers) {
      otpCode += controller.text;
    }

    if (otpCode == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PhoneDone()),
      );
    }
  }
  final List<TextEditingController> _controllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
        (_) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    _configureFocusListeners();
  }

  void _configureFocusListeners() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < _controllers.length - 1) {
          _focusNodes[i].unfocus();
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.08;
    return CommonUI(
          children: [
            const LogoImage(),
            const SizedBox(height: 16),
            const AutoFontSizeWidget(
              text:'Enter the code just sent to:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                    (index) => Container(
                  width:buttonHeight,
                  height: buttonHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < _controllers.length - 1) {
                        _focusNodes[index].unfocus();
                        _focusNodes[index + 1].requestFocus();
                      }
                      _checkOtpCode();
                    },
                    focusNode: _focusNodes[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoFontSizeWidget(
                  text:'Didn\'t get a Text? ',
                  style: TextStyle(fontSize: 19,color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700),
                          text: 'Send Again')),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeS()),
                );
              },
              child: AutoFontSizeWidget(text:"Login in another way",style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700),),
            )
          ],

    );
  }
}
