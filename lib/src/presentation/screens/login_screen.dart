import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';
import 'package:tutor_app/src/presentation/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please sign in to continue",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.35),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormWithBoxShadow(
                    textEditingController: usernameController,
                    icon: Icons.email_outlined,
                    hintText: "EMAIL",
                    focusNode: _focusNodes[0],
                  ),
                  const SizedBox(height: 40),
                  TextFormWithBoxShadow(
                    textEditingController: passwordController,
                    icon: Icons.lock_rounded,
                    hintText: "PASSWORD",
                    focusNode: _focusNodes[1],
                    isPasswordField: true,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      const Spacer(),
                      ButtonWithTextAndArrow(
                        text: "Login",
                        onTap: () {},
                        isActive: usernameController.value.text.isNotEmpty,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text("Don`t have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text('Sign up')),
                      Spacer(),
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
