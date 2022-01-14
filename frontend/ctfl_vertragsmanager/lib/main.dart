import 'dart:convert';

import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/pages/login.dart';
import 'package:ctfl_vertragsmanager/pages/onBoarding.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/partials/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'pages/mainPages.dart';
import 'pages/vertragHinzufuegen.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VertragAdapter());
  await Hive.openBox<Vertrag>('vertraege');

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

  void apiTesting() async {
    var url = Uri.parse('http://10.0.2.2:8080/api/users');
    var body = {
      "email": "abc@test.de",
      "password": "123456",
      "passwordConfirmation": "123456",
      "name": "Max"
    };
    var body_json = jsonEncode(body);
    var response = await http.post(
      url,
      body: body_json,
      headers: {"Content-Type": "application/json"},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
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
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorThemes.primaryColor,
          primary: ColorThemes.primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.blue),
        ),
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
  }

  void _getFirstBoot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = prefs.getBool("isFirstBoot") ?? true;
  }
}
