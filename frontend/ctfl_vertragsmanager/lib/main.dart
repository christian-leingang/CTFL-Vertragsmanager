import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/pages/login.dart';
import 'package:ctfl_vertragsmanager/pages/onBoarding.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/partials/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/mainPages.dart';
import 'pages/vertragHinzufuegen.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _isFirstBoot = true;

  @override
  void initState() {
    super.initState();
    _getFirstBoot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
      ],

      theme: ThemeData.light().copyWith(
        primaryColor: ColorThemes.primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: ColorThemes.primaryColor),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ColorThemes.primaryColor, primary: ColorThemes.primaryColor),
      ),

      darkTheme: ThemeData.dark(),
      //initialRoute: _isFirstBoot ? '/intro' : '/login',
      routes: {
        '/': (context) => Landing(),
        '/intro': (context) {
          _storeFirstBoot();
          return OnBoardingPage();
        },
        '/main': (context) => MainPages(),
        '/vertragsDetails': (context) => VertragsDetailsPage(),
        '/vertragHinzufuegen': (context) => VertragHinzufuegenPage(),
        '/login': (context) => LoginPage(),
      },
      //TODO: add theme und darkTheme mit ThemeData() (vgl. 7 Best Tips with Flutter 6. )
      //home: MainPages(),
    );
  }

  void _storeFirstBoot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = false;
    prefs.setBool("isFirstBoot", false);
    print(prefs.getBool("isFirstBoot"));
  }

  void _getFirstBoot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = prefs.getBool("isFirstBoot") ?? true;
  }
}
