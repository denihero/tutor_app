import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/course/courses_cubit.dart';
import 'package:tutor_app/src/logic/cubit/history/history_cubit.dart';
import 'package:tutor_app/src/presentation/components/button_with_text_and_arrow.dart';
import 'package:tutor_app/src/presentation/components/textform_with_boxshadow.dart';
import 'package:tutor_app/src/presentation/screens/home/home_screen.dart';
import 'package:tutor_app/src/presentation/screens/registration_screen.dart';

import '../../logic/blocs/authetication/authentication_bloc.dart';
import '../../logic/cubit/categories/categories_cubit.dart';
import '../../logic/cubit/saved/favorite_cubit.dart';

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
  bool check(String name, String password) {
    if (name.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
          // get_surveys_stream_fixed("").listen(print);
          if (state is AuthInitial ||
              state is AuthError ||
              state is AuthRegisterSuccess) {
            return SafeArea(
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
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            const Spacer(),
                            ButtonWithTextAndArrow(
                              text: "Login",
                              onTap: () {
                                check(usernameController.text,
                                        passwordController.text)
                                    ? BlocProvider.of<AuthBloc>(context).add(
                                        AuthLogin(usernameController.text,
                                            passwordController.text),
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Entered invalid data!"),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            const Text(
                              "Don`t have an account? ",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RegistrationScreen()));
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 16),
                                )),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AuthSuccess || state.email != "") {
            String token = BlocProvider.of<AuthBloc>(context).state.token;
            BlocProvider.of<CategoriesCubit>(context).getCategory(token);
            BlocProvider.of<CoursesCubit>(context).fetchCourse(token);
            BlocProvider.of<FavoritesCubit>(context).loadSavedList(token);
            BlocProvider.of<HistoryCubit>(context).getCubitViewedCourses(token);
            return const HomeScreen();
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }, listener: (context, state) {
          state is AuthError
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid Email or password')))
              : null;
        }),
      ),
    );
  }
}
