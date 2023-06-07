import 'package:developscreens/commons/comn_ui.dart';
import 'package:developscreens/commons/resp_container.dart';
import 'package:developscreens/commons/heading_text.dart';
import 'package:developscreens/commons/logo_image.dart';
import 'package:developscreens/commons/resp_sizebox.dart';
import 'package:developscreens/screens/forget_pswd.dart';
import 'package:developscreens/screens/signup_mail.dart';
import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _mailController = TextEditingController();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    print(context);
    return CommonUI(
      backButton: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  WelcomeS()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeadingWidget(
            text: 'Don\'t have an account?',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF3B3838),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MailLogin()),
              );
            },
            child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        color: Color(0xEDE51B23),
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                    text: 'Sign up')),
          ),
        ],
      ),
      children: [
        const LogoImage(),
        const ResponsiveSizedBox(height: 30),
        const HeadingWidget(text: "Welcome Back"),
        const ResponsiveSizedBox(height: 6),
        const HeadingWidget(
          text: 'Please login in to your account',
          fontWeight: FontWeight.normal,
          color: Color(0xff626064),
          fontSize: 14,
        ),
        const ResponsiveSizedBox(height: 30),
        Form(
          key: _emailFormKey,
          child: TextFormField(
            controller: _mailController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
        const ResponsiveSizedBox(height: 10),
        Form(
          key: _passwordFormKey,
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration:  InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixIcon:IconButton(
                icon: Icon(

                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xEDE51D23),
                ),
                onPressed: () {

                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            style: const TextStyle(fontSize: 12),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }

              if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
              }

              return null;
            },
          ),
        ),
        const ResponsiveSizedBox(height: 11),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgetPas()),
              );
            },
            child: const HeadingWidget(
              text: "Forgot Password?",
              fontSize: 14,
              color: Color(0xff3B3838),
            ),
          ),
        ),
        const ResponsiveSizedBox(height: 24),
        ResponsiveContainer(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xEDE51D23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const HeadingWidget(
                text: 'Sign In', color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
