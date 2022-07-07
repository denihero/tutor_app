import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:tutor_app/src/presentation/components/shimmer_for_theory_text.dart';

class CourseTheory extends StatelessWidget {
  const CourseTheory({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NetworkAssetBundle(Uri.parse(path)).loadString(''),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data!,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              builders: {
                'code': CodeElementBuilder(),
              },
              styleSheetTheme:MarkdownStyleSheetBaseTheme.cupertino,
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
              ),
            );
          }else if(snapshot.hasError){
            return const Text('Some Error');
          }
          return const ShimmerForTheoryText();
        });
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
