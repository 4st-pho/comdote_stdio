import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String assetsIcon;
  final VoidCallback onTap;
  const ImageButton({Key? key, required this.assetsIcon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Image.asset(
          assetsIcon,
          height: 24,
        ));
  }
}
