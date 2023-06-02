import 'package:flutter/material.dart';

class ResponsiveSizedBox extends StatelessWidget {
  final double? height;

  const ResponsiveSizedBox({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 812; // 812 is the reference screen height
    final calculatedHeight = height != null ? height! * scaleFactor : 28 * scaleFactor;

    return SizedBox(
      height: calculatedHeight,
    );
  }
}

