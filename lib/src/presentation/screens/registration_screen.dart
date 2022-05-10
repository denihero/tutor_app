import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';
import 'package:tutor_app/src/presentation/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final List<FocusNode> _focusNodes = [
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  const Text(
                    "Create a new account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormWithBoxShadow(
                    icon: Icons.email_outlined,
                    hintText: "EMAIL",
                    focusNode: _focusNodes[0],
                  ),
                  const SizedBox(height: 40),
                  TextFormWithBoxShadow(
                    icon: Icons.lock_rounded,
                    hintText: "NEW PASSWORD",
                    focusNode: _focusNodes[1],
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 30),
                  TextFormWithBoxShadow(
                    icon: Icons.lock_rounded,
                    hintText: "PASSWORD CONFIRMATION",
                    focusNode: _focusNodes[2],
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Spacer(),
                      ButtonWithTextAndArrow(
                        text: "Register",
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      const Text("Already have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()));
                          },
                          child: const Text('Login')),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
