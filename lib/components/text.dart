import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.text,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 32,
        color: Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
