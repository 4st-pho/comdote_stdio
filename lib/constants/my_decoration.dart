import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';

class MyDecoration {
  static const outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: MyColor.grey),
  );

  static const underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: MyColor.primaryGrey, width: 2));
  static final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0.3),
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
    ],
    tileMode: TileMode.mirror,
  ));
}
