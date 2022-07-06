import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/models/user.dart';

class ProfileAvatar extends StatelessWidget {
  final File? file;
  const ProfileAvatar({Key? key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 56,
      backgroundColor: MyColor.background,
      child: CircleAvatar(
        radius: 52,
        backgroundColor: MyColor.primaryGrey,
        child: file == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(52),
                child: Image.network(currenUser.avatar))
            : ClipRRect(
                borderRadius: BorderRadius.circular(52),
                child: Image.file(file!)),
      ),
    );
  }
}
