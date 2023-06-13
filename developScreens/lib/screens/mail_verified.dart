import 'dart:async';

import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/signin_screen.dart';
import 'package:flutter/material.dart';


class MailDone extends StatefulWidget {
  const MailDone({Key? key}) : super(key: key);

  @override
  State<MailDone> createState() => _MailDoneState();
}

class _MailDoneState extends State<MailDone> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    // Start the timer when the widget is initialized
   _timer= Timer(const Duration(seconds: 2), () {
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );*/
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
        return const LoginPage();
      }), (r){
        return false;
      });
    });
  }
  @override
  void dispose() {
    // Cancel the timer in the dispose method
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)  {
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
              MaterialPageRoute(builder: (context) =>  const LoginPage()),
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
                          text: "Your Mail has successfully verified!",
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
