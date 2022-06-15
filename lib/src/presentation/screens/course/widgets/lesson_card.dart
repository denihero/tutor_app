import 'package:flutter/material.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/screens/lesson/lesson_screen.dart';
import 'package:video_player/video_player.dart';

class LessonCard extends StatefulWidget {
  const LessonCard({Key? key, required this.id, required this.lesson})
      : super(key: key);

  final int id;
  final Lesson lesson;

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://leadev.club:8000/media/videos/butterfly.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonScreen(
              id: widget.id,
              lesson: widget.lesson,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Color(0xFFC2D1E5),
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 9),
              child: Row(
                children: [
                  Text(
                    beautifiedIdText(widget.id),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.04,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.lesson.name ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.04,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                const SizedBox(width: 55),
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF878787),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  _controller.value.isInitialized
                      ? getProperTime(_controller.value.duration)
                      : "00:00",
                  style: const TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 7,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String getProperTime(Duration time) {
    String finalTime = time.toString().split('.').first.padLeft(8, "0");
    if (finalTime.length != 8) {
      return finalTime.substring(3);
    }
    return finalTime;
  }

  String beautifiedIdText(int id) {
    if (id.toString().length < 2) {
      return "0" + id.toString();
    }
    return id.toString();
  }
}
