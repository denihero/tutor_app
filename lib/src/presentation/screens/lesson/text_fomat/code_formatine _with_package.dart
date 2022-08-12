import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = 'cs';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String; // FOR WHAT
      language = lg.substring(9);
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
          theme: a11yDarkTheme,
          // Specify padding
          padding: const EdgeInsets.all(8),

          // Specify text style
          //textStyle: GoogleFonts.robotoMono(),
        ),
      ),
    );
  }
}