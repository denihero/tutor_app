import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/languages/cs.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:tutor_app/src/presentation/components/shimmer_for_theory_text.dart';
import 'package:tutor_app/src/presentation/screens/lesson/text_fomat/code_formatine%20_with_package.dart';


class CourseTheory extends StatelessWidget {
  const CourseTheory({Key? key, required this.path}) : super(key: key);

  final String path;

  /// READ FILE AND LOOKING FOR ``` THING LIKE
  /// ```dart
  ///
  /// ```
  // String parseSyntaxLanguage(var data) {
  //   var parsed = data;
  //   RegExp codeSign = RegExp(r'`{3} *');
  //   RegExp pattern = RegExp(r'`{3} *[\w]+');
  //   for (RegExpMatch match in pattern.allMatches(data)) {
  //     String? lang = match.group(0)?.split(codeSign)[1]; // parse a language identifier
  //     parsed = parsed.replaceFirst(match.group(0), '```$cs$lang$cs');
  //   } // CAUTION "\n" newline is required!
  //   return parsed;
  // }

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
              //syntaxHighlighter: LangSyntaxHighlighter(),///New way to format code, but not perfect(need to modify)
              builders: {
                'code': CodeElementBuilder()
              },
              styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  md.EmojiSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Some Error');
          }
          return const ShimmerForTheoryText();
        });
  }
}

