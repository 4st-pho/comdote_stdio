import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.color = Colors.deepPurple,
      this.iconSize = 22,
      this.buttonSize = 30})
      : super(key: key);
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final double iconSize;
  final double buttonSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, size: iconSize, color: Colors.white),
      ),
    );
  }
}
