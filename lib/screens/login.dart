import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import "package:phrase/widgets/password_field.dart";
import "package:phrase/widgets/email_field.dart";
import 'package:provider/provider.dart';
import 'package:phrase/providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SnackBar snackBar = SnackBar(
    content: Text("Error"),
    backgroundColor: Colors.red,
  );

  AppLocalizations _localization = AppLocalizationsEn();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _loginForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Form(
              key: _loginForm,
              autovalidateMode: _autoValidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Text(_localization.loginScreenTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 32),
                  EmailField(controller: _emailController),
                  const SizedBox(height: 24),
                  PasswordField(controller: _passwordController),
                  const SizedBox(height: 24),
                  _buildLoginButton(auth),
                  const SizedBox(height: 24),
                  _buildSignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(AuthProvider auth) {
    return FilledButton(
        onPressed: () {
          if (_loginForm.currentState!.validate()) {
            auth
                .login(_emailController.text, _passwordController.text)
                .then((response) {
              if (response['status']) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          } else {
            setState(() => _autoValidate = AutovalidateMode.onUserInteraction);
          }
        },
        child: auth.loggedInStatus != AuthStatus.authenticating
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  _localization.loginScreenButton.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: SizedBox(
                    height: 24,
                    width: 24,
                    child: const CircularProgressIndicator(
                        strokeWidth: 3, color: Colors.white))));
  }

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_localization.loginScreenNoUser),
        TextButton(
          child: Text(
            _localization.loginScreenSignUpButton,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
      ],
    );
  }
}
