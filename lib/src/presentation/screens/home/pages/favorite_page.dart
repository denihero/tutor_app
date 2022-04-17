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
          image: NetworkImage(
              "https://timeweb.com/ru/community/article/3c/3c0cefa6f99fda8d9596da474fc7e264.jpg"),
          title: "Python",
          rating: 4.5,
          views: 10,
          likes: 1,
          lessons: [
            Lesson(
                title: "Basics",
                videoUrl: "",
                definition:
                    "Aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba"),
            Lesson(
                title: "Begin",
                videoUrl: "",
                definition:
                    "Aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba aboba"),
          ],
        ),
      ),
    );
  }
}
