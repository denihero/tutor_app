import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tutor_app/src/logic/cubit/video/video_cubit.dart';
import 'package:tutor_app/src/models/models.dart';
import 'package:video_player/video_player.dart';
import 'package:markdown/markdown.dart' as md;
import '../../components/appbars/transparent_appbar.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

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
    String videoUrl = widget.lesson.videos![1].url;

    return BlocProvider<VideoCubit>(
      create: (context) => VideoCubit()..loadVideoFromNetwork(videoUrl),
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
                    ],
                  ),
                  child: BlocBuilder<VideoCubit, VideoState>(
                    builder: ((context, state) {
                      if (state is VideoLoadError) {
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                                "Loading video failed"),
                          ),
                        );
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
                                autoInitialize: true
                          )),
                        );
                      }

                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }),
                  )),
              const SizedBox(height: 77),
              Container(
                //margin: const EdgeInsets.symmetric(horizontal: 30),
                // constraints: const BoxConstraints(minWidth: 368),
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
                child: Column(
                  children: [
                    Text(
                      '${widget.lesson.description}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.04,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: FutureBuilder(
                              future: rootBundle.loadString("assets/file/read.md"),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Markdown(
                                      data: snapshot.data!,
                                      selectable: true,
                                      builders: {
                                      'code': CodeElementBuilder(),
                                      },
                                     styleSheetTheme:MarkdownStyleSheetBaseTheme.cupertino,
                                     extensionSet: md.ExtensionSet(
                                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                                      [md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        )
                      ),
                    )
                  ],
                ),
              ),
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

  TextSpan textHighLighter(String text){
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black
      )
    );
  }
}


class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = 'dart';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String; // FOR WHAT
      //language = lg.substring(9);
    }
    return SizedBox(
      width:
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: HighlightView(
          // The original code to be highlighted
          element.textContent,
          // Specify language
          // It is recommended to give it a value for performance
          language: language,

          // Specify highlight theme
          // All available themes are listed in `themes` folder
          theme:a11yDarkTheme,
          // Specify padding
          padding: const EdgeInsets.all(8),

          // Specify text style
          //textStyle: GoogleFonts.robotoMono(),
        ),
      ),
    );
  }
}