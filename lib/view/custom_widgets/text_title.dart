import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: Colors.blue),
      textAlign: TextAlign.left,
    );
  }
}
