import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final bool underline;
  final TextAlign? textAlign;
  const HeadingWidget({Key? key, required this.text, this.fontSize, this.fontWeight, this.color, this.overflow,this.underline = false, this.textAlign,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final scaleFactor = screenWidth / 375; // 375 is the reference screen width
    final desiredFontSize = fontSize != null ? fontSize! * scaleFactor : 22 * scaleFactor;
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: desiredFontSize,
        color: color ?? Colors.black,
        decoration: underline ? TextDecoration.underline : null,

      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}
