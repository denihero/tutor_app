import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/logic/cubit/course/courses_cubit.dart';
import 'package:tutor_app/src/logic/cubit/get_course_id/course_id_cubit.dart';
import 'package:tutor_app/src/logic/cubit/history/history_cubit.dart';
import 'package:tutor_app/src/logic/cubit/saved/favorite_cubit.dart';
import 'package:tutor_app/src/logic/cubit/search/search_cubit.dart';
import 'package:tutor_app/src/presentation/screens/login_screen.dart';

import 'logic/blocs/authetication/authentication_bloc.dart';
import 'logic/cubit/categories/categories_cubit.dart';

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
        BlocProvider<CoursesCubit>(
          create: (context) => CoursesCubit(),
        ),
        BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider<HistoryCubit>(create: (context) => HistoryCubit()),
        BlocProvider<CourseIdCubit>(create: (context) => CourseIdCubit())
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
