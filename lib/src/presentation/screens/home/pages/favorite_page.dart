import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/saved_courses_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<SavedCoursesCubit, SavedCoursesState>(
            builder: (context, state) {
              if (state is SavedCoursesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SavedCoursesError) {
                return const Center(
                    child: Text('There is error in saved list'));
              } else if (state is SavedCoursesEmpty) {
                return const Center(
                  child: Text('There course is empty'),
                );
              } else if (state is SavedCoursesCompleted) {
                final data = state.savedList;
                return Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CourseCard(
                            course: Course(
                                nameOfCourse:
                                    data[index].course?[0].nameOfCourse,
                                category: data[index].course?[0].category,
                                lessons: data[index].course?[0].lessons,
                                images: data[index].course?[0].images,
                                likes: data[index].course![0].likes));
                      }),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
