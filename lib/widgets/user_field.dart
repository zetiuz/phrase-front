import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';

//const String errorLenght = 'Debe tener maximo 16 caracteres';
//const int maxNameLenght = 16;

const String pattern =
    r"^[a-zA-Z0-9]([.](?![.])|[a-zA-Z0-9]){0,14}[a-zA-Z0-9]$";
final regExp = RegExp(pattern);

class UserField extends StatefulWidget {
  const UserField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<UserField> createState() => _UserField();
}

class _UserField extends State<UserField> {
  AppLocalizations localization = AppLocalizationsEn();

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);

    return CustomTextField(
      maxLength: 16,
      labelText: localization.userLabelText,
      hintText: localization.userLabelHint,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localization.emailLabelNull;
        } else if (!regExp.hasMatch(value)) {
          return localization.userLabelError;
        }
        return null;
      },
      controller: widget.controller,
    );
  }
}
