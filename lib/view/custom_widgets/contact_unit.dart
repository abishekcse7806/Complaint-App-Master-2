import 'package:e_complaint/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:e_complaint/view/custom_widgets/caption_text.dart';
import 'package:e_complaint/constants/themes.dart';

class ContactUnit extends StatelessWidget {
  const ContactUnit(
      {Key? key,
      required this.heading,
      required this.content,
      required this.url})
      : super(key: key);

  final String heading;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CaptionText(text: heading),
          TextButton(
            onPressed: () async {
              await url_launcher.canLaunch(url)
                  ? await url_launcher.launch(url)
                  : throw kTextNotAvailable;
            },
            child: Text(
              content,
              style: kContactStyle,
              textAlign: kContactAlign,
            ),
          ),
        ],
      ),
    );
  }
}
