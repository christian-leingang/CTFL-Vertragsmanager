import 'dart:convert';

import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/pages/login.dart';
import 'package:ctfl_vertragsmanager/pages/onBoarding.dart';
import 'package:ctfl_vertragsmanager/pages/vertraege.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/partials/landing.dart';
import 'package:ctfl_vertragsmanager/provider/vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/label.dart';
import 'pages/mainPages.dart';
import 'pages/vertragHinzufuegen.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VertragAdapter());
  Hive.registerAdapter(LabelAdapter());
  await Hive.openBox<Vertrag>('vertraege');
  await Hive.openBox<Label>('labels');
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
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Vertrag_Provider(),
        ),
      ],
      child: MaterialApp(
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorThemes.primaryColor,
            primary: ColorThemes.primaryColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            floatingLabelStyle: TextStyle(color: ColorThemes.primaryColor),
          ),
        ),

        darkTheme: ThemeData.dark(),
        //initialRoute: _isFirstBoot ? '/intro' : '/login',
        routes: {
          '/': (context) => Landing(),
          '/intro': (context) {
            return OnBoardingPage();
          },
          '/main': (context) {
            return MainPages();
          },
          '/vertragsDetails': (context) => VertragsDetailsPage(),
          '/vertragHinzufuegen': (context) => VertragHinzufuegenPage(),
          '/login': (context) {
            _storeFirstBoot();
            return LoginPage();
          },
        },
        //TODO: add theme und darkTheme mit ThemeData() (vgl. 7 Best Tips with Flutter 6. )
        //home: MainPages(),
      ),
    );
  }

  void _storeFirstBoot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstBoot", false);
  }

  void _getFirstBoot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = prefs.getBool("isFirstBoot") ?? true;
  }
}
