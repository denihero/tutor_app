import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  final TextEditingController _loginTEController = TextEditingController();

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
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please sign in to continue",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.35),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextFormWithBoxShadow(
                    textEditingController: _loginTEController,
                    icon: Icons.email_outlined,
                    hintText: "EMAIL",
                    focusNode: _focusNodes[0],
                  ),
                  SizedBox(height: 40),
                  TextFormWithBoxShadow(
                    icon: Icons.lock_rounded,
                    hintText: "PASSWORD",
                    focusNode: _focusNodes[1],
                    isPasswordField: true,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Spacer(),
                      ButtonWithTextAndArrow(
                        text: "Login",
                        onTap: () {},
                        isActive: _loginTEController.value.text.isNotEmpty,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text("Don`t have an account? "),
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
