import 'dart:convert';
import 'dart:io';
import 'package:ctfl_vertragsmanager/funktionen/dbFunctions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool _isFirstBoot = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    print(healthCheck());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = (prefs.getBool('isFirstBoot') ?? true);
    print("First Boot: " + _isFirstBoot.toString());
    _isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);

    //_isFirstBoot = true; //TODO: Anmeldescreen an und ausschalten
    if (_isFirstBoot) {
      prefs.setBool('isFirstBoot', false);
      _isFirstBoot = false;

      Navigator.pushNamedAndRemoveUntil(context, '/intro', ModalRoute.withName('/intro'));
    } else {
      print("im Else");

      if (_isLoggedIn) {
        updateData();
        Navigator.pushNamedAndRemoveUntil(context, '/main', ModalRoute.withName('/main'));
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<void> updateData() async {
    await getAllLabels();
    //TODO: Muss wieder rein
    print("updateData");
    await getAllVertraege();
  }
}
