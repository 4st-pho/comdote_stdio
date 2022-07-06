import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/change_image_bloc.dart';
import 'package:stdio_week_6/blocs/loading_bloc.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_color.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/models/user.dart';
import 'package:stdio_week_6/pages/widgets/profile_text_form_field_name.dart';
import 'package:stdio_week_6/services/cloud_firestore/user_firestore.dart';
import 'package:stdio_week_6/services/firebase_auth/firebase_auth_methods.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFIle;
  final _changeImageBloc = ChangeImageBloc();
  final _loadingBloc = LoadingBloc();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController.text = currenUser.name;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _loadingBloc.dispose();
    _changeImageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context: context);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              _buildPickImage(),
              _buildForm(),
              const SizedBox(height: 120),
              _buildAllButton()
            ],
          ),
        ),
      ),
    );
  }

  Row _buildAllButton() {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 2,
          child: StreamBuilder<bool>(
            stream: _loadingBloc.stream,
            initialData: false,
            builder: (context, snapshot) {
              final isLoading = snapshot.data!;
              return Column(
                children: [
                  CustomButton(
                    text: ConstString.update,
                    onPressed: isLoading
                        ? null
                        : () async {
                            hideKeyboard(context: context);
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _loadingBloc.toggleState();
                            await UserFirestore().updateUserProfile(
                                name: _nameController.text,
                                file: _imageFIle,
                                context: context,
                                avataLink: currenUser.avatar);
                            _loadingBloc.toggleState();
                            resetUser();
                          },
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Change image',
                    onPressed: isLoading
                        ? null
                        : () async => await _changeImageBloc.getImage(),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Log out',
                    color: Colors.red,
                    onPressed: isLoading
                        ? null
                        : () async => await FirebaseAuthMethods()
                            .logOut(context: context),
                  ),
                ],
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Row _buildForm() {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: Form(
            key: _formKey,
            child: ProfileTextFormFeildName(nameController: _nameController),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  StreamBuilder<File?> _buildPickImage() {
    return StreamBuilder<File?>(
      stream: _changeImageBloc.stream,
      initialData: null,
      builder: (context, snapshot) {
        final file = snapshot.data;
        _imageFIle = file;

        return CircleAvatar(
          radius: 56,
          backgroundColor: MyColor.background,
          child: CircleAvatar(
            radius: 52,
            backgroundColor: MyColor.primaryGrey,
            child: file == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(52),
                    child: Image.network(
                      currenUser.avatar,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(52),
                    child: Image.file(
                      file,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )),
          ),
        );
      },
    );
  }
}
