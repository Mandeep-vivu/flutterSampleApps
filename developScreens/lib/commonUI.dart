import 'package:flutter/material.dart';
class CommonUI extends StatelessWidget {
  final List<Widget> children;
  final Widget? footer;
  final Widget? backButton;

  const CommonUI({
    Key? key,
    required this.children,
    this.footer,
    this.backButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: const Color(0xfffaeaea),
      body: SafeArea(
        child: Column(
          children: [
            if (backButton != null) backButton!,
            Expanded(
              child: Center(
                child: Container(
                  width: containerWidth,
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 21),
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          ...children,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}
