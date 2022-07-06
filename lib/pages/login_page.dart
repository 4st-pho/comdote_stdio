import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/loading_bloc.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/animation/custom_page_transition.dart';
import 'package:stdio_week_6/helper/build_password_text_form_field.dart';
import 'package:stdio_week_6/helper/build_text_form_field.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/pages/sign_up_page.dart';
import 'package:stdio_week_6/pages/reset_password_page.dart';
import 'package:stdio_week_6/services/firebase_auth/firebase_auth_methods.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';
import 'package:stdio_week_6/widgets/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _loadingBloc = LoadingBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loadingBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context: context);
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              _buildHeaderContent(),
              const SizedBox(height: 28),
              Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(children: [
                    _buildForm(),
                    const SizedBox(height: 40),
                    StreamBuilder<bool>(
                        stream: _loadingBloc.stream,
                        initialData: false,
                        builder: (context, snapshot) {
                          final isLoading = snapshot.data!;
                          return CustomButton(
                            text: ConstString.login,
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
                                        .signinWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            context: context);
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    _loadingBloc.toggleState();
                                  },
                          );
                        })
                  ])),
              const SizedBox(height: 8),
              _getForgotPassword(context),
              const SizedBox(height: 40),
              _getSignUp(context),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHeaderContent() {
    return Column(
      children: const [
        SizedBox(height: 100),
        Logo(),
        SizedBox(height: 92),
        Text(ConstString.welcomeToComdote, style: MyFont.blackHeading),
        SizedBox(height: 4),
        Text(ConstString.aliveWithYourStyleOfLiving,
            style: MyFont.greySubtitle),
      ],
    );
  }

  InkWell _getForgotPassword(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResetPasswordPage(
                initEmail: _emailController.text,
              ))),
      child: const Text(
        ConstString.forgotPassword,
        style: MyFont.blueSubtitle,
      ),
    );
  }

  RichText _getSignUp(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: MyFont.blackText,
        text: ConstString.youDoNotHaveAnAccount,
        children: [
          TextSpan(
            text: ConstString.signUpHere,
            style: MyFont.blueSubtitle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context)
                    .push(CustomPageTransition(child: const SignUpPage()));
              },
          ),
        ],
      ),
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
        ],
      ),
    );
  }
}
