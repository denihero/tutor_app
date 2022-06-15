import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/saved/favorite_cubit.dart';
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
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesError) {
            return const Center(child: Text('There is error in saved list'));
          }
          if (state is FavoritesEmpty) {
            return const Center(
              child: Text('There is nothing'),
            );
          }
          if (state is FavoritesCompleted) {
            final courses = state.favoritesList;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (BuildContext context, int index) {
                        Course course = courses[index];
                        return CourseCard(
                            course: Course(
                                name: course.name,
                                categoryName:
      course.categoryName,
lessons: course.lessons,
                                images: course.images,
                                likes: course.likes));
                      }),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
