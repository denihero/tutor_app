import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/api.dart';
import 'package:tutor_app/src/logic/cubit/get_course_id/course_id_cubit.dart';
import 'package:tutor_app/src/logic/cubit/history/history_cubit.dart';
import 'package:tutor_app/src/logic/cubit/saved/favorite_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/components/shimmer_load_course_screen.dart';

import 'package:tutor_app/src/presentation/screens/course/widgets/course_presentation.dart';
import 'package:tutor_app/src/presentation/screens/course/widgets/lesson_card.dart';

import '../../../logic/blocs/authetication/authentication_bloc.dart';
import '../../components/appbars/transparent_appbar.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late String token;
  late bool isLiked;

  bool isLikeTrigerred = false;

  @override
  void initState() {
    super.initState();

    token = BlocProvider.of<AuthBloc>(context).state.token;

    BlocProvider.of<CourseIdCubit>(context)
        .getCourseCubitById(token, widget.course.id);

    isLiked = context.read<FavoritesCubit>().savedCourses.map(
      (e) {
        return e.id;
      },
    ).contains(widget.course.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await controlSaveCourse();

        return true;
      },
      child: Scaffold(
        appBar: TransparentAppBar(
          title: const Text(
            "Детали видео урока",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await controlSaveCourse();

                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<CourseIdCubit, CourseIdState>(
            builder: (context, courseState) {
              if (courseState is CoursesIdLoaded) {
                BlocProvider.of<HistoryCubit>(context)
                    .getCubitViewedCourses(token);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CoursePresentation(
                        course: widget.course,
                        isLiked: isLiked,
                        onLikeTapped: () {
                          isLikeTrigerred = !isLikeTrigerred;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 6.5),
                        child: Text(
                          "Видео уроки",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.04,
                          ),
                        ),
                      ),
                      widget.course.lessons!.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "На этом курсе нет уроков",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: widget.course.lessons?.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        LessonCard(
                                  id: index + 1,
                                  lesson: widget.course.lessons![index],
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              }
              if (courseState is CoursesIdError) {
                return const Center(
                  child: Text('Something get wrong'),
                );
              }
              if (courseState is CoursesIdLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const ShimmerLoadCourseScreen(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 6.5),
                          child: Text(
                            "Видео уроки",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.04,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const ShimmerLoadLesson();
                            }),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  controlSaveCourse() async {
    if (isLikeTrigerred) {
      await saveCourses(token, widget.course.id);

      context.read<FavoritesCubit>().loadSavedList(token);
    }
  }
}
