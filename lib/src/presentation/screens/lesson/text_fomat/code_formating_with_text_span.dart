import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart';

class LangSyntaxHighlighter extends SyntaxHighlighter {
  final String language = 'cs';
  final String _rootKey = 'root';
  final String _defaultFontFamily = 'monospace';
  final Color _defaultFontColor = Colors.black;
  final Map<String, TextStyle> theme = a11yLightTheme; // User's code theme

  LangSyntaxHighlighter();

  @override
  TextSpan format(String source) {
    String? lang;
    if (source.startsWith(language)) {
      int idx = source.indexOf(language, language.length);
      lang = source.substring(language.length, idx);
      source = source.substring(idx + language.length);
    }
    TextStyle _textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: _defaultFontColor,
    );
    return TextSpan(
      style: _textStyle,
      children: _convert(highlight.parse(source, autoDetection: true, language: lang).nodes),
    );
  }

  List<TextSpan> _convert(List<Node>? nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node? node) {
      if (node?.value != null) {
        currentSpans.add(node?.className == null
            ? TextSpan(text: node?.value)
            : TextSpan(text: node?.value, style: theme[node?.className]));
      } else if (node?.children != null) {
        List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node?.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node?.children?.forEach((n) {
          _traverse(n);
          if (n == node.children?.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
          return ;
        }

        );
      }else{
        return 0;
      }

    }

    for (var node in nodes!) {
      _traverse(node);
    }
    return spans;
  }
}