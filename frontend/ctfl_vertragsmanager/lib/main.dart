import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/mainPages.dart';
import 'pages/vertragHinzufuegen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorThemes.primaryColor),
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainPages(),
        '/vertragsDetails': (context) => VertragsDetailsPage(),
        '/vertragHinzufuegen': (context) => VertragHinzufuegenPage(),
      },
      //TODO: add theme und darkTheme mit ThemeData() (vgl. 7 Best Tips with Flutter 6. )
      home: MainPages(),
    );
  }
}
