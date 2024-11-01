import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TypewriterMarkdown extends StatefulWidget {
  final String text;
  final Duration duration;

  const TypewriterMarkdown({
    super.key,
    required this.text,
    required this.duration,
  });

  @override
  TypewriterMarkdownState createState() => TypewriterMarkdownState();
}

class TypewriterMarkdownState extends State<TypewriterMarkdown> {
  String displayedText = '';

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  Future<void> _animateText() async {
    for (int i = 0; i <= widget.text.length; i++) {
      setState(() {
        displayedText = widget.text.substring(0, i);
      });
      await Future.delayed(widget.duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: displayedText,
      styleSheet: MarkdownStyleSheet(
        p: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
