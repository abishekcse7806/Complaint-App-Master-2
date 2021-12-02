import 'package:flutter/material.dart';

import 'package:e_complaint/constants/themes.dart';

class CaptionText extends StatelessWidget {
  const CaptionText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: kCaptionAlign,
      style: kCaptionStyle,
    );
  }
}
