import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class DottedImage extends StatelessWidget {
  final VoidCallback onPressed;
  const DottedImage({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: MyColor.grey,
      strokeWidth: 1,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 139,
          height: 139,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AssetsIcon.gallery, height: 24),
              const SizedBox(height: 5),
              Text(
                ConstString.addImage,
                style: MyFont.greySubtitle
                    .copyWith(decoration: TextDecoration.underline),
              )
            ],
          )),
        ),
      ),
    );
  }
}
