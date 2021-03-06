import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_font.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    String title = '',
    bool error = false,
    int milisecond = 1200}) {
  final snackBar = SnackBar(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.isNotEmpty)
          Row(children: [
            Expanded(child: Text(title.trim().toUpperCase(), style: MyFont.whiteTitle))
          ]),
        if (title.isNotEmpty) const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(content.trim(), style: MyFont.whiteTitle),
            ),
          ],
        ),
      ],
    ),
    duration: Duration(milliseconds: milisecond),
    backgroundColor: error ? Colors.red : Colors.green,
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    // margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    // behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
