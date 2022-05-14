import 'package:flutter/material.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/home/pages/widgets/course_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFC2D1E5),
                  offset: Offset(0, -1),
                  blurRadius: 11,
                )
              ]),
          child: const Image(
            image: NetworkImage(
                "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"),
          ),
        ),
        SizedBox(height: 44),
        Text(
          "Имя Фамилие",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
        SizedBox(height: 67),
        Padding(
          padding: EdgeInsets.only(left: 30, bottom: 7),
          child: Row(
            children: [
              Text(
                "Просмотренные",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.04,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => CourseCard(
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
          ),
        ),
      ],
    );
  }
}
