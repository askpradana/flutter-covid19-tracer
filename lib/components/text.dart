import 'package:flutter/material.dart';
import 'package:humanize_big_int/humanize_big_int.dart';

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

class TextBigData extends StatelessWidget {
  const TextBigData({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontweight,
    required this.title,
  }) : super(key: key);

  final String title;
  final int text;
  final double? fontSize;
  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: [
          Text(
            humanizeInt(text),
            style: TextStyle(
              fontSize:
                  fontSize ?? MediaQuery.of(context).size.shortestSide / 16,
              fontWeight: fontweight ?? FontWeight.w300,
            ),
          ),
          Text(title.toUpperCase()),
        ],
      ),
    );
  }
}
