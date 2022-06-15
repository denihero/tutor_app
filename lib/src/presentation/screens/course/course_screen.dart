import 'package:flutter/material.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/components/appbars/transparent_appbar.dart';
import 'package:tutor_app/src/presentation/screens/course/widgets/course_presentation.dart';
import 'package:tutor_app/src/presentation/screens/course/widgets/lesson_card.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoursePresentation(course: widget.course),
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
              Expanded(
                child: ListView.builder(
                  itemCount: widget.course.lessons?.length,
                  itemBuilder: (BuildContext context, int index) => LessonCard(
                    id: index + 1,
                    lesson: widget.course.lessons![index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
