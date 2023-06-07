import 'package:developscreens/screens/welcome_to_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xfffff9f9),systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xfffff9f9),statusBarIconBrightness: Brightness.dark
    ));
    return MaterialApp(
      debugShowCheckedModeBanner:false ,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android:CupertinoPageTransitionsBuilder(),
          },
        ),
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),


      home:const WelcomeS(),
    );
  }
}
