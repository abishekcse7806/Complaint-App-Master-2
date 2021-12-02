import 'package:flutter/material.dart';

const kDisabledColor = Color(0xffb0bec5);
const kMainColor = Color(0xff44AA1D);
const kAccentColor = Colors.white;
const kSplashColor = Colors.greenAccent;
const kLightTextColor = Color(0xff546e7a);
const kWhiteTextColor = Colors.white;
const kLineColor = Colors.black12;
const kMediumTextColor = Colors.black54;
const kDarkTextColor = Color(0xff000000);
Color kTransPanelColor = kSplashColor.withOpacity(0.90);
const kAmberColor=Colors.amberAccent;
const kRedColor=Colors.red;


const kCenterAlign = TextAlign.center;
const kCaptionAlign = TextAlign.left;
const kContactAlign = TextAlign.right;

const kCaptionStyle = TextStyle(
  color: kMainColor,
  fontWeight: FontWeight.w400,
  fontSize: 15,
);

const kHeaderStyle = TextStyle(
  color: kMainColor,
  fontWeight: FontWeight.w600,
  fontSize: 18,
);

const kDropIcon = Icon(
  Icons.keyboard_arrow_down_rounded,
  color: kLightTextColor,
  size: 25,
);
const kContactStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.lightBlue,
);

const kButtonTextStyle = TextStyle(
  color: kWhiteTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

const kMacIDStyle = TextStyle(
  color: kMediumTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

const kAppbarTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 22,
  fontWeight: FontWeight.w500,
);

const kLinkStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);

const kFieldHintStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: kDisabledColor,
);

const kFieldTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: kDarkTextColor,
);

ButtonStyle kButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
    foregroundColor: MaterialStateProperty.all<Color>(kWhiteTextColor));

ButtonStyle kDisabledButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(kDisabledColor),
    foregroundColor: MaterialStateProperty.all<Color>(kMainColor));

const kCornerRadius = BorderRadius.all(Radius.circular(8.0));

const kInputBorder = OutlineInputBorder(
  borderSide: BorderSide(),
  borderRadius: kCornerRadius,
);

const kFocusedInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2.0,
    color: kMainColor,
  ),
  borderRadius: kCornerRadius,
);

const EdgeInsetsGeometry kFormFieldPadding = EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0);