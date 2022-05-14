import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';
import 'package:tutor_app/src/presentation/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/blocs/authetication/authentication_bloc.dart';

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
    FocusNode(),
  ];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

  bool check(String name, String password, String repeat) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(name);
    if (name.isEmpty ||
        password.length < 6 ||
        password != repeat ||
        !emailValid) {
      return false;
    }
    return true;
  }

  TextEditingController? _codeController;
  TextEditingController? _nameController;
  TextEditingController? _surnameController;

  bool _isShowNameSurname = false;
  bool _isShowCodeConfirm = false;

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  pickImage() async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      setState(() {
        imageFile = File(image.path);
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _codeController?.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Some error occurred'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Center(child: Text("OK")),
                      ),
                    ],
                  );
                });
          } else if (state is AuthInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              ModalRoute.withName('/'),
            );
          } else if (state is AuthConfirmPasswordSucces) {
            setState(() {
              _isShowNameSurname = true;
              // _isShowCodeConfirm = false;
            });
            _nameController = TextEditingController();
            _surnameController = TextEditingController();

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Please enter Your name and surname"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).pushNamed("/login");
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Center(child: Text("OK")),
                      ),
                    ],
                  );
                });
          } else if (state is AuthRegisterSuccess) {
            setState(() {
              _isShowCodeConfirm = true;
            });
            _codeController = TextEditingController();
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content:
                        const Text("Check your email for confirmation code"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context).pushNamed("/login");
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Center(child: Text("OK")),
                      ),
                    ],
                  );
                });
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 17.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _isShowCodeConfirm && _isShowNameSurname == false
                              ? 'Enter Code'
                              : _isShowNameSurname
                                  ? "Enter name and surname"
                                  : "Create account",
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: _isShowNameSurname ? 2.h : 7.h,
                      ),
                      !_isShowCodeConfirm
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50),
                                TextFormWithBoxShadow(
                                  icon: Icons.email_outlined,
                                  hintText: "EMAIL",
                                  textEditingController: usernameController,
                                  focusNode: _focusNodes[0],
                                ),
                                const SizedBox(height: 40),
                                TextFormWithBoxShadow(
                                  icon: Icons.lock_rounded,
                                  hintText: "NEW PASSWORD",
                                  focusNode: _focusNodes[1],
                                  textEditingController: passwordController,
                                  isPasswordField: true,
                                ),
                                const SizedBox(height: 30),
                                TextFormWithBoxShadow(
                                  icon: Icons.lock_rounded,
                                  hintText: "PASSWORD CONFIRMATION",
                                  focusNode: _focusNodes[2],
                                  textEditingController:
                                      passwordRepeatController,
                                  isPasswordField: true,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    const Spacer(),
                                    ButtonWithTextAndArrow(
                                      text: "Register",
                                      onTap: () {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) {
                                          print('work');
                                          final email = usernameController.text;
                                          final password =
                                              passwordController.text;
                                          final repeat =
                                              passwordRepeatController.text;
                                          check(email, password, repeat)
                                              ? BlocProvider.of<AuthBloc>(
                                                      context)
                                                  .add(
                                                  AuthRegister(email, password),
                                                )
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Entered invalid data!"),
                                                  ),
                                                );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const Text(''),
                      _isShowCodeConfirm && !_isShowNameSurname
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormWithBoxShadow(
                                  icon: Icons.email_outlined,
                                  hintText: "Confirmation Code",
                                  textEditingController: _codeController,
                                  focusNode: _focusNodes[3],
                                ),
                                SizedBox(
                                  height: 1.8.h,
                                ),
                                ButtonWithTextAndArrow(
                                  text: 'Send code',
                                  onTap: () {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback((_) {
                                      final code = _codeController?.text;

                                      final email = usernameController.text;
                                      BlocProvider.of<AuthBloc>(context).add(
                                          AuthConfirmPassword(email, "", code));
                                    });
                                  },
                                )
                              ],
                            )
                          : const Text(""),
                      _isShowNameSurname
                          ? Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: pickImage,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: imageFile != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  imageFile!,
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              )
                                            : const Text(
                                                "Upload",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                        radius: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormWithBoxShadow(
                                      icon: Icons.person,
                                      hintText: "Name",
                                      focusNode: _focusNodes[0],
                                    ),
                                    SizedBox(
                                      height: 1.8.h,
                                    ),
                                    TextFormWithBoxShadow(
                                      icon: Icons.person,
                                      hintText: "Surname",
                                      focusNode: _focusNodes[0],
                                    ),
                                    SizedBox(
                                      height: 1.8.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ButtonWithTextAndArrow(
                                          text: 'Confirm',
                                          onTap: () {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              final code =
                                                  _codeController?.text;
                                              final email =
                                                  usernameController.text;
                                              print(email);
                                              print(passwordController.text);
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(
                                                AuthRegisterSendNameSurname(
                                                  name: _nameController?.text ??
                                                      "",
                                                  file: imageFile,
                                                  surname: _surnameController
                                                          ?.text ??
                                                      '',
                                                  username: email,
                                                  password:
                                                      passwordController.text,
                                                ),
                                              );
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          : const Text(''),
                      const Spacer(),
                      Row(
                        children: [
                          const Spacer(),
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              )),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 40)
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
