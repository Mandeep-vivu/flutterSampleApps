import 'package:developscreens/commonUI.dart';
import 'package:developscreens/commonfonts.dart';
import 'package:developscreens/screens/ForgetPas.dart';
import 'package:developscreens/screens/welcome.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.06;
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    return CommonUI(
  backButton:   Align(
    alignment: Alignment.topLeft,
    child: IconButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeS()),
      );
    },
      icon: const Icon(Icons.arrow_back),),
  ),
       footer: Container(
         padding: const EdgeInsets.symmetric(vertical: 3),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Text(
               'Don\'t have an account?',
               style: TextStyle(fontSize: 14),
             ),
             GestureDetector(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const WelcomeS()),
                 );
               },
               child: RichText(
                   text: const TextSpan(
                       style: TextStyle(
                           color: Color(0xEDE51D23),
                           fontWeight: FontWeight.w700),
                       text: 'Sign up')),
             ),
           ],
         ),
       ),
          children: [

            Image.asset(
              'assets/logo.png',
              height: 150,
              width: 150,
            ),
            const AutoFontSizeWidget(
              text:'Welcome Back',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const AutoFontSizeWidget(text:"Please login in to your account",style: TextStyle(color: Colors.black54,fontSize: 17),),
            const SizedBox(height: 30),
            SizedBox(
              width: containerWidth,
              height: buttonHeight,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email/Phone",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),

                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email or Phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: containerWidth,
              height: buttonHeight,
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye,
                      color: Color(0xEDE51D23)),
                ),
                style: const TextStyle(fontSize: 12),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgetPas()),
                  );
                },
                child: const Text("Forgot Password?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xEDE51D23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  AutoFontSizeWidget(
                    text:'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
    );
  }
}

