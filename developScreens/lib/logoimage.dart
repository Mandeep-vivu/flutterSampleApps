import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double height;
  final double width;

  const LogoImage({Key? key, this.height = 150, this.width = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: height,
      width: width,
    );
  }
}
