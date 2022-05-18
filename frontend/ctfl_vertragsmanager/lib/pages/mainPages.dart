import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/pages/vertraege.dart';
import 'package:ctfl_vertragsmanager/partials/filter.dart';
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

  final screens = [
    VertraegePage(),
    const KalenderPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedItemColor: ColorThemes.primaryColor,
      ),
    );
  }
}
