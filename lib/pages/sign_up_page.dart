import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/loading_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/build_password_text_form_field.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/helper/show_snackbar.dart';
import 'package:stdio_week_6/services/firebase_auth/firebase_auth_methods.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';
import 'package:stdio_week_6/widgets/logo.dart';

import '../helper/build_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _loadingBloc = LoadingBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _loadingBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context: context);
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              _buildTextContent(),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    _buildForm(),
                    const SizedBox(height: 40),
                    StreamBuilder<bool>(
                      stream: _loadingBloc.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        final isLoading = snapshot.data!;
                        return CustomButton(
                          text: 'Sign up',
                          onPressed: isLoading
                              ? null
                              : () async {
                                  hideKeyboard(context: context);
                                  _loadingBloc.toggleState();
                                  if (!_formKey.currentState!.validate()) {
                                    _loadingBloc.toggleState();
                                    return;
                                  }
                                  FirebaseAuthMethods()
                                      .signUpWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          context: context)
                                      .then(
                                    (value) async {
                                      if (value == 'success') {
                                        showSnackBar(
                                            context: context, content: value);
                                      } else {
                                        _loadingBloc.toggleState();
                                      }
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                    },
                                  );
                                },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
            icon: Image.asset(
              AssetsIcon.arrowBack,
              height: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0);
  }

  Column _buildTextContent() {
    return Column(
      children: const [
        SizedBox(height: 40),
        Logo(),
        SizedBox(height: 92),
        Text(ConstString.signUpComdote, style: MyFont.blackHeading),
        SizedBox(height: 4),
        Text(ConstString.aliveWithYourStyleOfLiving,
            style: MyFont.greySubtitle),
      ],
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BuildTextFormFeild(
              controller: _emailController,
              title: ConstString.email,
              type: TextInputType.emailAddress,
              showLabel: false),
          const SizedBox(height: 16),
          BuildPasswordTextFormField(
              controller: _passwordController,
              title: ConstString.password,
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return ConstString.pleaseEnterSomeText;
                }
                if (value.length <= 7) {
                  return ConstString.passwordMustBeMoreThan7Characters;
                }
                return null;
              }),
          const SizedBox(height: 16),
          BuildPasswordTextFormField(
              controller: _confirmPasswordController,
              title: ConstString.confirmPassword,
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return ConstString.pleaseEnterSomeText;
                }
                if (value.length <= 7) {
                  return ConstString.passwordMustBeMoreThan7Characters;
                }
                if (value != _passwordController.text) {
                  return ConstString.notTheSameAsThePassword;
                }
                return null;
              }),
        ],
      ),
    );
  }
}
