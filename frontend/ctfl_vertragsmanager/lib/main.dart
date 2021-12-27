import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:flutter/material.dart';

import 'pages/mainPages.dart';

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
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainPages(),
        '/vertragsDetails': (context) => VertragsDetailsPage(),
      },
      //TODO: add theme und darkTheme mit ThemeData() (vgl. 7 Best Tips with Flutter 6. )
      home: MainPages(),
    );
  }
}
