import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField(
      {super.key, required this.controller, required this.password});

  final TextEditingController controller;
  final TextEditingController password;

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordField();
}

class _ConfirmPasswordField extends State<ConfirmPasswordField> {
  AppLocalizations localization = AppLocalizationsEn();
  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);

    return CustomTextField(
      obscureText: passwordHidden,
      suffixIcon: IconButton(
        icon: Icon(passwordHidden ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(
            () {
              passwordHidden = !passwordHidden;
            },
          );
        },
      ),
      labelText: localization.confirmPasswordFieldText,
      hintText: localization.confirmPasswordFieldHint,
      validator: passwordValidator,
      controller: widget.controller,
    );
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return localization.passwordLabelNull;
    } else if (value != widget.password.text) {
      return localization.confirmPasswordFieldError;
    }
    return null;
  }
}
