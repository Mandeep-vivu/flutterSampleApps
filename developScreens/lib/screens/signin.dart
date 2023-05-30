import 'package:developscreens/commonUI.dart';
import 'package:developscreens/screens/ForgetPas.dart';
import 'package:developscreens/screens/welcome.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Text("Please login in to your account",style: TextStyle(color: Colors.black54,fontSize: 17),),
            const SizedBox(height: 30),
            SizedBox(
              width: containerWidth,
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xEDE51D23),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const ListTile(
                title: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
    );
  }
}

