import 'package:flutter/material.dart';

class BaseNavBar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;

  const BaseNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<BaseNavBar> createState() => _BaseNavBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _BaseNavBarState extends State<BaseNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
