import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_app/src/logic/cubit/saved/favorite_cubit.dart';
import 'package:tutor_app/src/presentation/components/shimmer_load_coure_card.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return const ShimmerLoadCardWidget();
            },
          );
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
                      return CourseCard(
                        course: courses[index].course!,
                        isForFavoritePage: courses[index].saved!,
                      );
                    }),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
