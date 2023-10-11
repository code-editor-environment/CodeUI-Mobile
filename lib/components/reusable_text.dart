import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      softWrap: true,
      textAlign: TextAlign.left,
      overflow: TextOverflow.clip,
      style: style,
    );
  }
}
