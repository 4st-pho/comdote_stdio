import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';

class CustomButton extends StatelessWidget {
  final bool infiniti;
  final String text;
  final Color color;
  final double minWidth;
  final VoidCallback? onPressed;
  const CustomButton(
      {this.infiniti = true,
      this.color = MyColor.blue,
      required this.text,
      Key? key,
      required this.onPressed,
      this.minWidth = 233})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize:
              infiniti ? const Size(double.infinity, 53) : Size(minWidth, 53),
          elevation: 0,
          onPrimary: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      onPressed: onPressed,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
