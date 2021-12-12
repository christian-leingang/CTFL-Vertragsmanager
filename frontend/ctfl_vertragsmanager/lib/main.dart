//import 'package:ctfl_vertragsmanager/partials/appbar.dart';
//import 'package:ctfl_vertragsmanager/partials/navbar.dart';
import 'package:ctfl_vertragsmanager/pages/kalender.dart';
import 'package:ctfl_vertragsmanager/pages/profil.dart';
import 'package:ctfl_vertragsmanager/pages/vertraege.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  final appbars = [
    AppBar(
      centerTitle: true,
      backgroundColor: Color(0xffD72324),
      leading: Image(image: AssetImage('assets/logo.jpg')),
      title: Text(
        "Verträge",
      ),
      actions: [
        Icon(
          Icons.filter_alt_outlined,
          size: 30,
        ),
        Icon(
          Icons.import_export_outlined,
          size: 30,
        ),
      ],
    ),
    AppBar(
      centerTitle: true,
      backgroundColor: Color(0xffD72324),
      leading: Image(image: AssetImage('assets/logo.jpg')),
      title: Text(
        "Kalender",
      ),
    ),
    AppBar(
      centerTitle: true,
      backgroundColor: Color(0xffD72324),
      leading: Image(image: AssetImage('assets/logo.jpg')),
      title: Text(
        "Profil",
      ),
      actions: [
        Icon(Icons.edit_outlined),
        Icon(Icons.delete_outlined),
      ],
    ),
  ];

  final screens = [
    VertraegePage(),
    KalenderPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //AppBar
        appBar: appbars[currentIndex],

        //Seiteninhalt
        body: screens[currentIndex],

        //NavBar
        //bottomNavigationBar: BaseNavBar(currentIndex: currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Verträge',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Kalender',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          selectedItemColor: Color(0xffD72324),
        ),
      ),
    );
  }
}
