import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';

// Minimo 8 caracteres
const String pattern = r"^.{8,}$";
final regExp = RegExp(pattern);

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  AppLocalizations localization = AppLocalizationsEn();
  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);

    return CustomTextField(
      //prefixIcon: const Icon(Icons.lock),
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
      labelText: localization.passwordLabelText,
      hintText: localization.passwordLabelHint,
      validator: passwordValidator,
      controller: widget.controller,
    );
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return localization.passwordLabelNull;
    } else if (!regExp.hasMatch(value)) {
      return localization.passwordLabelLenght;
    }
    return null;
  }
}
