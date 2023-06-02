import 'package:flutter/material.dart';

class AutoFontSizeWidget extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AutoFontSizeWidget({
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
      final mediaQuery = MediaQuery.of(context);
      final screenWidth = mediaQuery.size.width;
      // Calculate the desired font size based on the screen width
      final scaleFactor = screenWidth / 375; // 375 is the reference screen width
      final fontSize = style.fontSize! * scaleFactor;

    return Text(
      text,
      style: style.copyWith(fontSize: fontSize,fontFamily: 'Open Sans',
      ),
    );
  }
}
