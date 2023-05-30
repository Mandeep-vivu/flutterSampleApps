import 'package:developscreens/screens/finishSignup.dart';
import 'package:flutter/material.dart';

class MailDone extends StatelessWidget {
  const MailDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaeaea),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FinishSup()),
            );
            /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
            );*/
          },
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 21),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xEDEF9BA2),width: 20),
                                color: const Color(0xEDE51D23)
                            ),
                            child: const Icon(Icons.check,size: 120,color: Colors.white,)),
                        const SizedBox(height: 25,),
                        const Text("Your Mail has successfully verified!",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,)
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
