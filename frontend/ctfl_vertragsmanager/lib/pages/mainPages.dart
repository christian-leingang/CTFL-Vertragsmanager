import 'package:ctfl_vertragsmanager/pages/vertraege.dart';
import 'package:flutter/material.dart';

import 'kalender.dart';
import 'profil.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentIndex = 0;
  final appbars = [
    AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xffD72324),
      leading: const Image(image: AssetImage('assets/logo.jpg')),
      title: const Text(
        "Verträge",
      ),
      actions: const [
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
      backgroundColor: const Color(0xffD72324),
      leading: const Image(image: AssetImage('assets/logo.jpg')),
      title: const Text(
        "Kalender",
      ),
    ),
    AppBar(
      centerTitle: true,
      backgroundColor: const Color(0xffD72324),
      leading: const Image(image: AssetImage('assets/logo.jpg')),
      title: const Text(
        "Profil",
      ),
    ),
  ];

  final screens = [
    VertraegePage(),
    const KalenderPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: appbars[currentIndex],

      //Seiteninhalt
      body: Container(
        child: screens[currentIndex],
      ),

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
        selectedItemColor: const Color(0xffD72324),
      ),
    );
  }
}
