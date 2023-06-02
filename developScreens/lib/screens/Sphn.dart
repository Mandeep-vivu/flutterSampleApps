import 'package:developscreens/commons/heading.dart';
import 'package:developscreens/responSized.dart';
import 'package:developscreens/screens/finishSignup.dart';
import 'package:flutter/material.dart';

class PhoneDone extends StatelessWidget {
  const PhoneDone({Key? key}) : super(key: key);

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
            Navigator.push(
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
                        ResponsiveSizedBox(
                          height: 28,
                        ),
                        HeadingWidget(
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
