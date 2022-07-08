import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final IconData icon;
  final VoidCallback onPress;
  const CustomIconButton(
      {Key? key,
      this.color = MyColor.blue,
      required this.onPress,
      required this.icon,
      this.iconColor = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPress,
      ),
    );
  }
}