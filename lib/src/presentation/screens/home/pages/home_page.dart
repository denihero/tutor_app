import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tutor_app/src/logic/blocs/authetication/authentication_bloc.dart';
import 'package:tutor_app/src/logic/cubit/categories/categories_cubit.dart';
import 'package:tutor_app/src/logic/cubit/course/courses_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/shimmer_load_categories_badges_widget.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/shimmer_load_coure_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? choiceIndex;
  List<String> categoryNames = [];
  late String token;
  @override
  void initState() {
    token = BlocProvider.of<AuthBloc>(context).state.token;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await Future.delayed(const Duration(seconds: 1));
          BlocProvider.of<CoursesCubit>(context).fetchCourse(token);
      },
      child: Column(
        children: [
          Container(
            //не изменять, потому что ломается кликние баджей
            height: 40,
            margin: const EdgeInsets.only(left: 17, bottom: 43),
            child: BlocBuilder<CategoriesCubit, Cat>(
              builder: (context, state) {
              if(state is CategoriesLoading){
                return ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return const ShimmerLoadCategoriesBadgesWidget();
                    });
              }else if(state is Categories){
                categoryNames = state.categories.keys.toList();
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryNames.length - categoryNames.length + 1,
                    itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Wrap(
                          spacing: 10,
                          children: techChips(index,context),
                        )));
              }
              return Container();

            },

            ),
          ),
          BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              if (state is CoursesLoading) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context,index){
                        return const ShimmerLoadCardWidget();
                      }
                  ),
                );
              }
              if (state is CoursesCompleted) {
                var courses = state.courses;
                return Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: courses.length,
                      itemBuilder: (BuildContext context, int index) {
                        Course course = courses[index];
                        return CourseCard(
                          course: Course(
                              name: course.name,
                              categoryName: course.categoryName,
                              lessons: course.lessons,
                              images: course.images,
                              id: course.id,
                              likes: course.likes),
                        );
                      }),
                );
              }

              return Column(
                children: const [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 60,
                    color: Colors.black38,
                  ),
                  Text(
                    "Something get wrong",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> techChips(int index,BuildContext context) {
    String token = BlocProvider.of<AuthBloc>(context).state.token;
    List<Widget> chips = [];
    for (int i = 0; i < categoryNames.length; i++) {
      Widget item = ChoiceChip(
        label: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            categoryNames[i],
            style: TextStyle(fontSize: 11.sp),
          ),
        ),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        selectedColor: const Color(0xFFFE793D),
        selected: choiceIndex == i,
        shadowColor: Colors.black,
        labelStyle: choiceIndex == i
            ? const TextStyle(
                color: Colors.white,
              )
            : const TextStyle(
                color: Colors.black,
              ),
        onSelected: (isSelected) {
          setState(() {
            if (isSelected) {
              choiceIndex = i;
              BlocProvider.of<CoursesCubit>(context)
                  .fetchCourseFromCategory(categoryNames[choiceIndex!],token);
            } else {
              BlocProvider.of<CoursesCubit>(context).fetchCourse(token);
              choiceIndex = null;
            }
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }
}
