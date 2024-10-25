import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final double? fontSize;
  final double borderRadius;

  const CommonButton(
      {super.key,
      required this.title,
      required this.textColor,
      required this.buttonColor,
      required this.onPressed,
      required this.borderRadius,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
