import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commons/heading.dart';
import 'package:developscreens/logoimage.dart';
import 'package:developscreens/responSized.dart';
import 'package:developscreens/screens/Sphn.dart';
import 'package:developscreens/screens/welcome.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/services.dart'; // Import the services package for clipboard access
class OtpVerify extends StatefulWidget {
  const OtpVerify({
    Key? key,
    required this.mobileNumber,
    required this.countryCode,
  }) : super(key: key);

  final String mobileNumber;
  final String countryCode;

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _otpCodes = List.generate(4, (_) => '');
  late List<TextEditingController> _controllers;
  late Timer _timer;
  int _countdownSeconds = 10;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
          (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      _countdownSeconds = 10;
      _isVisible = true;
    });

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_countdownSeconds < 1) {
          timer.cancel();
          _isVisible = false;
        } else {
          _countdownSeconds = _countdownSeconds - 1;
        }
      });
    });
  }

  void _onChanged(int index, String value) {
    _otpCodes[index] = value;

    if (value.isNotEmpty) {
      if (index < _controllers.length - 1) {
        // If the current field is not the last one, move focus to the next field
        _controllers[index + 1].text = '';
        FocusScope.of(context).nextFocus();
      } else {
        // If the current field is the last one, unfocus to dismiss the keyboard
        FocusScope.of(context).unfocus();

        // Validate OTP codes
        bool isOtpValid = true;
        for (var otpCode in _otpCodes) {
          if (otpCode.isEmpty) {
            isOtpValid = false;
            break;
          }
        }

        // If all OTP codes are filled correctly, navigate to the next screen
        if (isOtpValid) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PhoneDone()),
          );
        }
      }
    } else if (value.isEmpty && index > 0) {
      // If the current field is empty and not the first one, move focus to the previous field
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 790; // 812 is the reference screen height
    final buttonHeight = 60 * scaleFactor;

    return CommonUI(
      children: [
        LogoImage(),
        const ResponsiveSizedBox(height: 30),
        HeadingWidget(
          text:
          'Enter the code just sent to:\n${widget.countryCode} ${widget.mobileNumber}',
          fontSize: 16,
        ),
        const ResponsiveSizedBox(height: 30),
        Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
                  (index) => Container(
                width: buttonHeight,
                height: buttonHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: TextFormField(
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
                  onChanged: (value) => _onChanged(index, value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
        ResponsiveSizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeadingWidget(
              text: 'Didn\'t get a Text? ',
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            GestureDetector(
              onTap: () {
                startCountdown();
              },
              child: HeadingWidget(
                text: 'Send Again',
                fontSize: 16,
                underline: true,
              ),
            ),
          ],
        ),
        Visibility(
          visible: _isVisible,
          child: HeadingWidget(
            text: 'Code will be received in $_countdownSeconds seconds',
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.redAccent,
          ),
        ),
        ResponsiveSizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeS()),
            );
          },
          child: HeadingWidget(
            text: "Login in another way",
            fontSize: 16,
            underline: true,
          ),
        ),
      ],
    );
  }
}
