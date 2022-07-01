import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/pages/login.dart';
import 'package:ctfl_vertragsmanager/pages/on_boarding.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/partials/landing.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:ctfl_vertragsmanager/provider/new_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/label.dart';
import 'pages/main_pages.dart';
import 'pages/vertrag_hinzufuegen.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VertragAdapter());
  Hive.registerAdapter(LabelAdapter());
  await Hive.openBox<Vertrag>('vertraege');
  await Hive.openBox<Label>('labels');
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

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
        ChangeNotifierProvider(create: (context) => NewVertragProvider()),
        ChangeNotifierProvider(create: (context) => CurVertragProvider()),
        ChangeNotifierProvider(create: (context) => AllVertraegeProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
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
        darkTheme: ThemeData.dark().copyWith(
          canvasColor: const Color.fromARGB(255, 0, 0, 0),
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorThemes.primaryColor,
            selectionHandleColor: ColorThemes.primaryColor,
          ),
          colorScheme: const ColorScheme.dark(
            onSurface: Colors.white,
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            surface: Colors.pink,
          ),
        ),
        initialRoute: _isFirstBoot ? '/intro' : '/login',
        routes: {
          '/': (context) => const Landing(),
          '/intro': (context) {
            return const OnBoardingPage();
          },
          '/main': (context) {
            return const MainPages();
          },
          '/vertragsDetails': (context) => const VertragsDetailsPage(),
          '/vertragHinzufuegen': (context) => const VertragHinzufuegenPage(),
          '/login': (context) {
            _storeFirstBoot();
            return const LoginPage();
          },
        },
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
