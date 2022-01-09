import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool _isFirstBoot = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = (prefs.getBool('isFirstBoot') ?? true);
    print(prefs.getString("profile"));

    //_isFirstBoot = true; //TODO: Anmeldescreen an und ausschalten
    if (_isFirstBoot) {
      Navigator.pushNamedAndRemoveUntil(context, '/intro', ModalRoute.withName('/intro'));
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/main', ModalRoute.withName('/main'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
