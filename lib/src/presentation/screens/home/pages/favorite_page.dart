import 'package:flutter/material.dart';
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
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => CourseCard(
        isForFavoritePage: true,
        course: Course(
        ),
      ),
    );
  }
}
