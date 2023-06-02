import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 812; // 812 is the reference screen height
    final buttonHeight = 80 * scaleFactor;
    return SizedBox(
      width: buttonHeight,
      height: buttonHeight,
      child: Image.asset(
        'assets/logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
