import 'package:developscreens/commons/resp_sizebox.dart';
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
      backgroundColor: const Color(0xfffff9f9),
      body: SafeArea(
        child: Column(
          children: [
            if (backButton != null) backButton!,
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
               // Replace with desired color
                    ),
                    width: containerWidth,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...children,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const ResponsiveSizedBox(height: 12,),
            if (footer != null) footer!,
            const ResponsiveSizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
}
