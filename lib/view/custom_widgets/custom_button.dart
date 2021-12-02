import 'package:flutter/material.dart';

import 'package:e_complaint/constants/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.buttonLabel, required this.onPress, required this.enabled})
      : super(key: key);

  final Function onPress;
  final String buttonLabel;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          style: enabled ? kButtonStyle : kDisabledButtonStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child: Text(
              buttonLabel,
              style: kButtonTextStyle,
            ),
          ),
          onPressed: () => onPress(),
        ),
      ),
    );
  }
}
