import 'dart:io';

import 'package:flutter/material.dart';

class ImageBorder extends StatelessWidget {
  final File imageFile;
  const ImageBorder({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Image.file(
        imageFile,
        height: 162,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
