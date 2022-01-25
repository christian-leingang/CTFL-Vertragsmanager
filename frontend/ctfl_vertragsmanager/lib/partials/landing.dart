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

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    //TODO: wieder entkommentieren
    //getAllLabels();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = (prefs.getBool('isFirstBoot') ?? true);

    //_isFirstBoot = true; //TODO: Anmeldescreen an und ausschalten
    if (_isFirstBoot) {
      Navigator.pushNamedAndRemoveUntil(context, '/intro', ModalRoute.withName('/intro'));
    } else {
      updateData(prefs.getString("profile")!);
      Navigator.pushNamedAndRemoveUntil(context, '/main', ModalRoute.withName('/main'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void updateData(String profilePref) {
    Map<String, dynamic> map = jsonDecode(profilePref);
    getAllLabels();
    //TODO: Muss wieder rein
    //getAllVertraege(map["id"]);
  }
}
