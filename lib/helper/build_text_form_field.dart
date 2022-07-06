import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_decoration.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class BuildTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final String subtitle;
  final String title;
  final TextInputType type;
  final bool showLabel;
  final double spaceBetweenLabelAndTextfeild;
  const BuildTextFormFeild(
      {required this.controller,
      this.subtitle = '',
      required this.title,
      required this.type,
      this.showLabel = true,
      this.spaceBetweenLabelAndTextfeild = 8,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showLabel ? Text(title, style: MyFont.blackTitle) : const SizedBox(),
        SizedBox(height: spaceBetweenLabelAndTextfeild),
        TextFormField(
          style: const TextStyle(fontSize: 14, height: 1.47),
          minLines: 1,
          maxLines: type == TextInputType.multiline ? 10 : 1,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            isDense: true,
            border: MyDecoration.outlineInputBorder,
            hintText: showLabel ? 'Input for ${title.toLowerCase()}' : title,
            fillColor: Colors.transparent,
            filled: true,
            hintStyle: MyFont.greySubtitle,
            enabledBorder: MyDecoration.outlineInputBorder,
            focusedBorder: MyDecoration.outlineInputBorder,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (value.length < 5) {
              return 'Do not less than 5 characters.';
            }
            if (value.length > 300) {
              return 'Do not exceed 300 characters when entering.';
            }
            return null;
          },
        ),
        subtitle.isNotEmpty
            ? const SizedBox(height: 8)
            : const SizedBox(height: 0),
        subtitle.isNotEmpty
            ? Text(subtitle, style: MyFont.greySubtitle)
            : const SizedBox(),
      ],
    );
  }
}
