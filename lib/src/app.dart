import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/logic/cubit/course__cubit.dart';
import 'package:tutor_app/src/presentation/screens/home/home_screen.dart';
import 'package:tutor_app/src/presentation/screens/login_screen.dart';
import 'package:tutor_app/src/presentation/screens/registration_screen.dart';

import 'logic/blocs/authetication/authentication_bloc.dart';
import 'logic/categories_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: true,
          create: (context) => AuthBloc(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(),
        ),
        BlocProvider<SurveyCubit>(
          create: (context) => SurveyCubit(),
        ),
      ],
      child: Sizer(
        builder: ((context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: const LoginScreen(),
          );
        }),
      ),
    );
  }
}
