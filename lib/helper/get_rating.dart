import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';

List<Widget> getRating(double rating, {double height = 16}) {
  int start = rating.round();
  final starYellow = List.generate(
    start,
    (_) => Padding(
      padding: const EdgeInsets.all(2),
      child: Image.asset(
      AssetsIcon.star,
        height: height,
      ),
    ),
  );
  final starGrey = List.generate(
    5 - start,
    (_) => Padding(
      padding: const EdgeInsets.all(2),
      child: Image.asset(
        AssetsIcon.greyStar,
        height: height,
      ),
    ),
  );
  return [...starYellow, ...starGrey];
}
