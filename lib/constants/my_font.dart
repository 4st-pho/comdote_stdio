import 'package:flutter/cupertino.dart';
import 'package:stdio_week_6/constants/my_color.dart';

class MyFont {
  static const greyHeading = TextStyle(fontSize: 20, color: MyColor.grey);
  static const greyTitle = TextStyle(fontSize: 16, color: MyColor.grey);
  static const greySubtitle = TextStyle(fontSize: 14, color: MyColor.grey);

  static const blackHeading = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: MyColor.black);
  static const blackText = TextStyle(fontSize: 14, color: MyColor.black);
  static const blackTextSmall = TextStyle(fontSize: 12, color: MyColor.black);
  static const blackTitle = TextStyle(
      fontSize: 16, color: MyColor.black, fontWeight: FontWeight.bold);
  static const blueHeadingB =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: MyColor.blue);
  static const blueHeading =
      TextStyle(fontSize: 20, color: MyColor.blue);
  static const blueTitle =
      TextStyle(fontSize: 16, color: MyColor.blue);
  static const blueTitleB =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColor.blue);
  static const blueSubtitle =
      TextStyle(fontSize: 14, color: MyColor.blue);
  static const whiteTitle = TextStyle(fontSize: 16, color: MyColor.white);
  static const whiteTitleB = TextStyle(
      fontSize: 16, color: MyColor.white, fontWeight: FontWeight.bold);
  static const whiteSubtitleB = TextStyle(
      fontSize: 14, color: MyColor.white, fontWeight: FontWeight.bold);
  static const whiteSpacing = TextStyle(
    color: MyColor.white,
    letterSpacing: 5,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(5, 5),
        blurRadius: 7,
        color: MyColor.grey,
      ),
    ],
  );
}
