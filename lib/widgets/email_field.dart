import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';

// RFC2822 Email Validation
const String pattern =
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
final regExp = RegExp(pattern);

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<EmailField> createState() => _EmailField();
}

class _EmailField extends State<EmailField> {
  AppLocalizations localization = AppLocalizationsEn();

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);

    return CustomTextField(
      //prefixIcon: const Icon(Icons.email),
      inputType: TextInputType.emailAddress,
      labelText: localization.emailLabelText,
      hintText: localization.emailLabelHint,
      validator: emailValidator,
      controller: widget.controller,
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return localization.emailLabelNull;
    } else if (!regExp.hasMatch(value)) {
      return localization.emailLabelInvalid;
    }
    return null;
  }
}
