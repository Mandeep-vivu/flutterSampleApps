import 'dart:async';

import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/profile_pic.dart';
import 'package:flutter/material.dart';

class PhoneDone extends StatefulWidget {
  const PhoneDone({Key? key}) : super(key: key);

  @override
  State<PhoneDone> createState() => _PhoneDoneState();
}

class _PhoneDoneState extends State<PhoneDone> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FinishSup()),
      );
    });
  }
  @override
  void dispose() {
    // Cancel the timer in the dispose method
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scaleFactor =
        screenHeight / 790; // 812 is the reference screen height
    final buttonHeight = 145 * scaleFactor;

    return Scaffold(
      backgroundColor: const Color(0xfffff9f9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FinishSup()),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xEDEF9BA2), width: 20),
                                color: const Color(0xEDE51D23)),
                            child: Icon(
                              Icons.check,
                              size: buttonHeight,
                              color: Colors.white,
                            )),
                        const ResponsiveSizedBox(
                          height: 28,
                        ),
                        const HeadingWidget(
                          text: "Your Phone number has successfully verified!",
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
