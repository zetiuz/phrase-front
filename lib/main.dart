import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phrase/screens/login.dart';
import "package:phrase/screens/register.dart";
import "package:phrase/screens/home.dart";
import 'package:provider/provider.dart';
import 'package:phrase/services/api_url.dart';
import 'package:phrase/providers/auth_provider.dart';
import 'package:phrase/providers/post_provider.dart';
import 'package:phrase/utilities/user_preferences.dart';
import 'package:phrase/models/user.dart';
import 'package:phrase/providers/user_provider.dart';

const phrasePrimaryColor = Color.fromRGBO(0, 108, 78, 1.0);
const String appTitle = "Phrase";
 
void main() {
  runApp(const Phrase());
}

class Phrase extends StatelessWidget {
  const Phrase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: phrasePrimaryColor,
          fontFamily: 'InterTight',
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}
