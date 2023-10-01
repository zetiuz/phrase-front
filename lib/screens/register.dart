import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import "package:phrase/widgets/confirm_password_field.dart";
import "package:phrase/widgets/password_field.dart";
import "package:phrase/widgets/email_field.dart";
import "package:phrase/widgets/user_field.dart";
import 'package:provider/provider.dart';
import 'package:phrase/providers/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  SnackBar snackBar = SnackBar(
    content: Text("Error"),
    backgroundColor: Colors.red,
  );

  AppLocalizations localization = AppLocalizationsEn();

  final _emailForm = GlobalKey<FormState>();
  final _usernameForm = GlobalKey<FormState>();
  final _passwordForm = GlobalKey<FormState>();

  AutovalidateMode _autoValidateEmailForm = AutovalidateMode.disabled;
  AutovalidateMode _autoValidateUsernameForm = AutovalidateMode.disabled;
  AutovalidateMode _autoValidatePasswordForm = AutovalidateMode.disabled;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _step = 0;

  late final textStyle = Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(fontWeight: FontWeight.bold);

  List<Step> get _stepsList => [
        Step(
          title: Text(localization.registerScreenLet, style: textStyle),
          content: _buildEmailStep(),
          state: _step > 0 ? StepState.complete : StepState.indexed,
          isActive: _step >= 0,
        ),
        Step(
          title: Text(localization.registerScreenSecurity, style: textStyle),
          content: _buildPasswordStep(),
          state: _step > 1 ? StepState.complete : StepState.indexed,
          isActive: _step >= 1,
        ),
        Step(
          title: Text(localization.registerScreenUser, style: textStyle),
          content: _buildUsernameStep(),
          state: _step > 2 ? StepState.complete : StepState.indexed,
          isActive: _step >= 2,
        ),
      ];

  Widget _buildEmailStep() {
    return Form(
      key: _emailForm,
      autovalidateMode: _autoValidateEmailForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EmailField(controller: _emailController),
          const SizedBox(height: 12)
        ],
      ),
    );
  }

  Widget _buildPasswordStep() {
    return Form(
      key: _passwordForm,
      autovalidateMode: _autoValidatePasswordForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PasswordField(controller: _passwordController),
          const SizedBox(height: 21),
          ConfirmPasswordField(
              controller: _confirmPasswordController,
              password: _passwordController),
          const SizedBox(height: 12)
        ],
      ),
    );
  }

  Widget _buildUsernameStep() {
    return Form(
      key: _usernameForm,
      autovalidateMode: _autoValidateUsernameForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UserField(controller: _usernameController),
          const SizedBox(height: 12)
        ],
      ),
    );
  }

  void _next() {
    setState(() {
      _step++;
    });
  }

  void _nextStep(AuthProvider auth) {
    switch (_step) {
      case 0:
        if (_emailForm.currentState!.validate()) {
          _next();
        } else {
          setState(() {
            _autoValidateEmailForm = AutovalidateMode.onUserInteraction;
          });
        }
        break;
      case 1:
        if (_passwordForm.currentState!.validate()) {
          _next();
        } else {
          setState(() {
            _autoValidatePasswordForm = AutovalidateMode.onUserInteraction;
          });
        }
        break;
      case 2:
        if (_usernameForm.currentState!.validate()) {
          auth
              .register(_usernameController.text, _emailController.text,
                  _passwordController.text)
              .then((response) {
            if (response['status']) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        } else {
          setState(() {
            _autoValidateUsernameForm = AutovalidateMode.onUserInteraction;
          });
        }
        break;
    }
  }

  void _previousStep() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
    }
  }

  Widget _buildNextButton(AuthProvider auth) {
    if (_step != (_stepsList.length - 1)) {
      return FilledButton(
          onPressed: () {
            _nextStep(auth);
          },
          child: Text(localization.registerScreenButton));
    } else {
      return FilledButton.icon(
          onPressed: () {
            //if (auth.registeredInStatus != AuthStatus.registering) {
            _nextStep(auth);
            //}
          },
          icon: auth.registeredInStatus != AuthStatus.registering
              ? Container()
              : Container(
                  width: 48,
                  height: 24,
                  padding: const EdgeInsets.fromLTRB(22, 2, 6, 2),
                  child: const CircularProgressIndicator(
                      strokeWidth: 3, color: Colors.white)),
          label: auth.registeredInStatus != AuthStatus.registering
              ? Text(localization.registerScreenFinish)
              : const Text(''));
    }
  }

  Widget _buildBackButton() {
    return OutlinedButton(
        onPressed: () {
          _previousStep();
        },
        child: Text(localization.registerScreenBack));
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Stepper(
        physics: const ScrollPhysics(),
        steps: _stepsList,
        currentStep: _step,
        controlsBuilder: (context, _) {
          return Row(
            children: <Widget>[
              _buildNextButton(auth),
              const SizedBox(width: 12),
              _buildBackButton()
            ],
          );
        },
      ),
    );
  }
}
