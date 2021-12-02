import 'package:e_complaint/constants/themes.dart';
import 'package:flutter/material.dart';


class HeaderText extends StatelessWidget {
  const HeaderText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: kCenterAlign,
      style: kHeaderStyle,
    );
  }
}
