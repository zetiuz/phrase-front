import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:phrase/widgets/custom_text_field.dart';
import 'package:phrase/widgets/post.dart';
import 'package:provider/provider.dart';
import 'package:phrase/models/post.dart';
import 'package:phrase/providers/post_provider.dart';

//const String errorLenght = 'Debe tener maximo 16 caracteres';
//const int maxNameLenght = 16;

const String pattern =
    r"^[a-zA-Z0-9]([.](?![.])|[a-zA-Z0-9]){0,125}[a-zA-Z0-9]$";
final regExp = RegExp(pattern);

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _Feed();
}

class _Feed extends State<Feed> {
  AppLocalizations localization = AppLocalizationsEn();

  List<Post> _publications = [];

 

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);
    final TextEditingController _searchController = TextEditingController();
    
    if(_publications.length == 0) {
    Provider.of<PostProvider>(context).getPublications().then((publications) {
      setState(() {
        _publications = publications;
      });
    });
    }

    return Container(
      //alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: ListView.builder(
        itemCount: _publications.length,
        itemBuilder: (context, index) {
          return PostWidget(
            username: _publications[index].userId,
            content: _publications[index].body,
            backgroundImage: _publications[index].imagen,
            isPost: true
          );
        },
      ),
    );
  }
}
