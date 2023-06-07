
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor = screenHeight / 785; // 812 is the reference screen height
    final buttonHeight = 44 * scaleFactor;
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: child,
    );
  }
}
