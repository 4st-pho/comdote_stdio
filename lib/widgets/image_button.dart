import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetsIcon;
  const ImageButton({
    Key? key,
    required this.onTap,
    required this.assetsIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          assetsIcon,
          height: 24,
        ),
      ),
    );
  }
}
