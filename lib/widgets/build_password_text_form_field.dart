import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/swap_show_hide_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/my_decoration.dart';
import 'package:stdio_week_6/constants/my_font.dart';

class BuildPasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?) onValidate;
  final bool isFocusNext;
  const BuildPasswordTextFormField(
      {Key? key,
      required this.controller,
      required this.title,
      required this.onValidate,
      this.isFocusNext = false})
      : super(key: key);

  @override
  State<BuildPasswordTextFormField> createState() =>
      _BuildPasswordTextFormFieldState();
}

class _BuildPasswordTextFormFieldState
    extends State<BuildPasswordTextFormField> {
  final _swapShowHidePassword = SwapShowHideBloc();
  @override
  void dispose() {
    _swapShowHidePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _swapShowHidePassword.stream,
      builder: (context, snapshot) {
        final isPasswordVisible = snapshot.data!;
        return TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isPasswordVisible,
          style: const TextStyle(fontSize: 14, height: 1.47),
          textInputAction:
              widget.isFocusNext ? TextInputAction.next : TextInputAction.none,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Image.asset(
                isPasswordVisible ? AssetsIcon.eye : AssetsIcon.eyeSlash,
                height: 24,
              ),
              onPressed: () => _swapShowHidePassword.toggleShow(),
            ),
            isDense: true,
            border: MyDecoration.outlineInputBorder,
            hintText: widget.title,
            fillColor: Colors.transparent,
            filled: true,
            hintStyle: MyFont.greySubtitle,
            enabledBorder: MyDecoration.outlineInputBorder,
            focusedBorder: MyDecoration.outlineInputBorder,
          ),
          validator: widget.onValidate,
        );
      },
    );
  }
}
