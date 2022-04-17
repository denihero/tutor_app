import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2),
                  Text(
                    "Create a new account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormWithBoxShadow(
                    icon: Icons.email_outlined,
                    hintText: "EMAIL",
                    focusNode: _focusNodes[0],
                  ),
                  SizedBox(height: 40),
                  TextFormWithBoxShadow(
                    icon: Icons.lock_rounded,
                    hintText: "NEW PASSWORD",
                    focusNode: _focusNodes[1],
                    isPasswordField: true,
                  ),
                  SizedBox(height: 30),
                  TextFormWithBoxShadow(
                    icon: Icons.lock_rounded,
                    hintText: "PASSWORD CONFIRMATION",
                    focusNode: _focusNodes[2],
                    isPasswordField: true,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Spacer(),
                      ButtonWithTextAndArrow(
                        text: "Register",
                        onTap: () {},
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text("Already have an account? "),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
