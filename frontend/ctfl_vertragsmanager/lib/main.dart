import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffD72324),
          title: Center(
            child: Text("Verträge"),
          ),
          // actions: <Widget>[
          //   (Image(
          //     image: AssetImage('assets/logo.jpg'),
          //   ))
          // ],
        ),
        body: Text("TestText"),
        bottomNavigationBar: BottomNavigationBar(
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
