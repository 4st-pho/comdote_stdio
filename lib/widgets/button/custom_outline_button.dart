import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {Key? key,
      this.infiniti = true,
      required this.text,
      required this.onPress,
      this.minWidth = 111})
      : super(key: key);
  final bool infiniti;
  final double minWidth;
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize:
              infiniti ? const Size(double.infinity, 53) : Size(minWidth, 53),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          side: const BorderSide(color: MyColor.grey)),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
