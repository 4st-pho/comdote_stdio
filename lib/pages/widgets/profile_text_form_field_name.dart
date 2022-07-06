import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/constants/my_decoration.dart';


class ProfileTextFormFeildName extends StatelessWidget {
  const ProfileTextFormFeildName({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: nameController,
      style: const TextStyle(
        color: MyColor.primaryGrey,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        enabledBorder:
            MyDecoration.underlineInputBorder,
        focusedBorder:
            MyDecoration.underlineInputBorder,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ConstString.pleaseEnterSomeText;
        }
        if (value.length < 2) {
          return ConstString.doNotLessThan2Characters;
        }
        if (value.length > 20) {
          return ConstString.doNotExceed20Characters;
        }
        return null;
      },
    );
  }
}