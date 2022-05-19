import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/components/appbars/transparent_appbar.dart';
import 'package:video_player/video_player.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key, required this.id, required this.lesson})
      : super(key: key);

  final int id;
  final Lesson lesson;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.lesson.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          beautifiedIdText(widget.id) + " " + widget.lesson.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFC2D1E5),
                      offset: Offset(0, -1),
                      blurRadius: 11,
                    )
                  ]),
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(
                          controller: ChewieController(
                        videoPlayerController: _controller,
                      )),
                    )
                  : const SizedBox(
                      width: double.infinity,
                      height: 204,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            const SizedBox(height: 77),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.only(
                top: 21,
                left: 15,
                bottom: 25,
                right: 19,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFC2D1E5),
                    offset: Offset(0, -1),
                    blurRadius: 11,
                  )
                ],
              ),
              child: Text(
                widget.lesson.definition,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String beautifiedIdText(int id) {
    if (id.toString().length < 2) {
      return "0" + id.toString();
    }
    return id.toString();
  }
}
