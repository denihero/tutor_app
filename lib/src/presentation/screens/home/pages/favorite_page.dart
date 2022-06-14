import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/saved/saved_cubit.dart';
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
          BlocBuilder<SavedCoursesCubit, SavedState>(
            builder: (context, state) {
              if (state is SavedLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SavedError) {
                return const Center(
                    child: Text('There is error in saved list'));
              } else if (state is SavedCompleted) {
                final data = state.savedList;
                return Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(data[index].course);
                        return CourseCard(
                            course: Course(
                                name: data[index].course?[index].name,
                                categoryName:
                                    data[index].course?[index].categoryName,
                                lessons: data[index].course?[index].lessons,
                                images: data[index].course?[index].images,
                                likes: data[index].course![index].likes));
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
