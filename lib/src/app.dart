import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/src/presentation/screens/home/home_screen.dart';
import 'package:tutor_app/src/presentation/screens/login_screen.dart';
import 'package:tutor_app/src/presentation/screens/registration_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LoginScreen(),
    );
  }
}