import 'package:fashion_ai/features/home/widgets/type_writer.dart';
import 'package:fashion_ai/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final bool isLastMessage;
  const MessageCard(
      {super.key, required this.message, required this.isLastMessage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (message.isQuestion) {
          // on long press copy the question to the clipboard
          Clipboard.setData(ClipboardData(text: message.query));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Question copied to clipboard'),
            ),
          );
        } else {
          // Handle long press on answer
          Clipboard.setData(ClipboardData(text: message.answer));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Answer copied to clipboard'),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: message.isQuestion
            ? const EdgeInsets.only(left: 50, bottom: 5, top: 5)
            : const EdgeInsets.only(right: 50, bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: message.isQuestion ? Colors.grey.shade900 : Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: message.isQuestion
                ? const Radius.circular(16)
                : const Radius.circular(0),
            topRight: message.isQuestion
                ? const Radius.circular(0)
                : const Radius.circular(16),
            bottomLeft: const Radius.circular(16),
            bottomRight: const Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            message.isQuestion
                ? Text(
                    message.query,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 8),
            !message.isQuestion &&
                    isLastMessage // Only show the typewriter effect for the last response
                ? TypewriterMarkdown(
                    text: message.answer,
                    duration: const Duration(
                        milliseconds: 20), // Adjust typing speed here
                  )
                : !message.isQuestion
                    ? MarkdownBody(
                        data: message.answer,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
