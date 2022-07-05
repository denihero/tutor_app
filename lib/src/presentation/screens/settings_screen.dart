import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/presentation/screens/widgets/profile_edit_icon.dart';

import '../../logic/blocs/authetication/authentication_bloc.dart';
import '../components/appbars/transparent_appbar.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Настройки",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return const ProfileEditIcon();
                  }),
                ],
              ),
              const SizedBox(height: 43),
              titleWithDetailes(
                  "Меня зовут", BlocProvider.of<AuthBloc>(context).state.name),

              const SizedBox(height: 33),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 49),
              //   child: titleWithDetailes("Обо мне", "Расскажите что нибудь"),
              // ),
              titleWithDetailes(
                  "Email", BlocProvider.of<AuthBloc>(context).state.email),
              const Spacer(),
              Material(
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(const AuthLogout());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                            (route) => false);
                  },
                  child: Row(
                    children:const[
                      Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                       SizedBox(width: 6),
                       Text(
                        "Выход",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWithDetailes(String title, String details) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            details,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.04,
            ),
          )
        ],
      );
}
