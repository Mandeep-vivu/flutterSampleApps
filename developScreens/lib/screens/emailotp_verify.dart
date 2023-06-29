import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/provider_aut.dart';
import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class EOtpVerify extends StatefulWidget {
  const EOtpVerify({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<EOtpVerify> createState() => _EOtpVerifyState();
}

class _EOtpVerifyState extends State<EOtpVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _otpCodes = List.generate(4, (_) => '');
  late List<TextEditingController> _controllers;
  Timer? _timer;
  int _countdownSeconds = 60;
  bool _isVisible = false;
  bool _isButtonEnabled = true;


  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      4,
      (_) => TextEditingController(),
    );
    startCountdown();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      _countdownSeconds = 60;
      _isVisible = true;
      _isButtonEnabled = false;
      // Disable the button
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_countdownSeconds < 1) {
          timer.cancel();
          _isVisible = false;
          _isButtonEnabled = true; // Enable the button
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
        _controllers[index + 1].text = '';
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
        bool isOtpValid = true;
        for (var otpCode in _otpCodes) {
          if (otpCode.isEmpty) {
            isOtpValid = false;
            break;
          }
        }

        if (isOtpValid) {
          verifyOtp();
        }
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  Future<void> verifyOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final otp = int.parse(_otpCodes.join(''));
    final verificationResult =
        await authProvider.verifyMOTP( otp, context, true);
    if (!verificationResult) {
      await stopCountdown(Future.value(false));
    }
  }
  Future<void> resendOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.sendVerifyEmail(context);
    startCountdown();
  }

  Future<bool> stopCountdown(Future<bool> stopFuture) async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      setState(() {
        _isVisible = false;
        _isButtonEnabled = true;
      });
      final bool result = await stopFuture;
      return result;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor =
        screenHeight / 790;
    final buttonHeight = 60 * scaleFactor;
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return CommonUI(
        children: [
          const LogoImage(),
          const ResponsiveSizedBox(height: 30),
          HeadingWidget(
            text: 'Enter the code just sent to:\n${widget.email}',
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
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
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
          const ResponsiveSizedBox(
            height: 30,
          ),
          Visibility(
            visible: !_isVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeadingWidget(
                  text: 'Didn\'t get a Text? ',
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                GestureDetector(
                  onTap: _isButtonEnabled ? resendOtp : null,
                  child: const HeadingWidget(
                    text: 'Send Again',
                    fontSize: 16,
                    underline: true,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: HeadingWidget(
              text: 'Code will be sent again in $_countdownSeconds seconds',
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.redAccent,
            ),
          ),
          const ResponsiveSizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeS()),
              );
            },
            child: const HeadingWidget(
              text: "Login in another way",
              fontSize: 16,
              underline: true,
            ),
          ),
        ],
      );
    });
  }
}
