import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:tutor_app/src/logic/cubit/video/video_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:tutor_app/src/presentation/components/appbars/transparent_appbar.dart';
import 'package:video_player/video_player.dart';
import 'course_theory.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key, required this.id, required this.lesson})
      : super(key: key);

  final int id;
  final Lesson lesson;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    String videoUrl = widget.lesson.videos![0].url;

    return BlocProvider<VideoCubit>(
      create: ((context) => VideoCubit()..loadVideoFromNetwork(videoUrl)),
      // create: (context) => VideoCubit()
      // ..loadVideoFromNetwork('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      child: Scaffold(
        appBar: TransparentAppBar(
          title: Text(
            widget.lesson.name!,
            style: const TextStyle(color: Colors.black),
          ),
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
          // title: Text(
          //   beautifiedIdText(widget.id) + " " + widget.lesson.name,
          //   style: const TextStyle(
          //     color: Colors.black,
          //     fontSize: 18,
          //     fontWeight: FontWeight.w600,
          //     letterSpacing: 1.04,
          //   ),
          // ),
        ),
        body: SafeArea(
          child: Stack(
            // fit:StackFit.expand,
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
                    ],
                  ),
                  child: BlocBuilder<VideoCubit, VideoState>(
                    builder: ((context, state) {
                      if (state is VideoLoadError) {
                        return SizedBox(
                            height: 200,
                            child: Image.asset(
                              'assets/image/error.png',
                              fit: BoxFit.cover,
                            ));
                      }
                      if (state is VideoLoading) {
                        return const SizedBox(
                          width: double.infinity,
                          height: 204,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is VideoLoaded) {
                        VideoPlayerController controller = state.controller;

                        return AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          // TODO: SPECIFY VIDEO CONTROLLER
                          child: Chewie(
                              controller: ChewieController(
                                  videoPlayerController: controller,
                                  autoInitialize: true)),
                        );
                      }

                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }),
                  )),
              const SizedBox(height: 77),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.7,
                    minChildSize: 0.7,
                    maxChildSize: 1,
                    builder: (context, scrollController) {
                      return Material(
                        color: Colors.white,
                        elevation: 10,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              CourseTheory(
                                path: widget.lesson.file,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
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

  TextSpan textHighLighter(String text) {
    return TextSpan(text: text, style: const TextStyle(color: Colors.black));
  }
}
