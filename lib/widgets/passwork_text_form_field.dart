import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/my_decoration.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?) onValidate;
  final bool isFocusNext;
  final Function(String value) onFieldSubmitted;
  final VoidCallback toggleShowPassword;
  final bool isPasswordVisible;
  final FocusNode? focusNode;
  const PasswordTextFormField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.onValidate,
      this.isFocusNext = false,
      required this.toggleShowPassword,
      this.focusNode,
      required this.isPasswordVisible,
      required this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      textInputAction:
          isFocusNext ? TextInputAction.next : TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
      style: const TextStyle(fontSize: 14, height: 1.47),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Image.asset(
            isPasswordVisible ? AssetsIcon.eye : AssetsIcon.eyeSlash,
            height: 24,
          ),
          onPressed: toggleShowPassword,
        ),
        isDense: true,
        border: MyDecoration.outlineInputBorder,
        hintText: title,
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: MyFont.greySubtitle,
        enabledBorder: MyDecoration.outlineInputBorder,
        focusedBorder: MyDecoration.outlineInputBorder,
      ),
      validator: onValidate,
    );
  }
}
