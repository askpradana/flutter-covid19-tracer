import 'package:covid_tracer/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ConstPict.backgroundPict,
      semanticsLabel: ConstText.backgroundSemanticsText,
      height: MediaQuery.of(context).size.longestSide / 2,
      fit: BoxFit.scaleDown,
    );
  }
}
