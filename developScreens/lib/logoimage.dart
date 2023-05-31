import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double height;
  final double width;

  const LogoImage({Key? key, this.height = 150, this.width = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final desiredWidth = screenSize.width * 0.4; // Adjust the multiplier as needed
    final desiredHeight = screenSize.height * 0.2;
    return Image.asset(
      'assets/logo.png',
      width: desiredWidth,
      height: desiredHeight,

    );
  }
}
