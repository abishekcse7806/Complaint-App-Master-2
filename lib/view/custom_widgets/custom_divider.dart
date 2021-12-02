import 'package:flutter/material.dart';

import 'package:e_complaint/constants/themes.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Divider(
        thickness: 1,
        color: kLineColor,
      ),
    );
  }
}
