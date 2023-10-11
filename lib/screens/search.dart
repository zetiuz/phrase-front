import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';

//const String errorLenght = 'Debe tener maximo 16 caracteres';
//const int maxNameLenght = 16;

const String pattern =
    r"^[a-zA-Z0-9]([.](?![.])|[a-zA-Z0-9]){0,125}[a-zA-Z0-9]$";
final regExp = RegExp(pattern);

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  AppLocalizations localization = AppLocalizationsEn();

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);
    final TextEditingController _searchController = TextEditingController();

    return Container(
      //alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: CustomTextField(
        maxLength: 127,
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
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        controller: _searchController,
      ),
    );
  }
}
