import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  LandingState createState() => LandingState();
}

class LandingState extends State<Landing> {
  bool _isFirstBoot = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstBoot = (prefs.getBool('isFirstBoot') ?? true);
    _isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);

    //_isFirstBoot = true; //TODO: Anmeldescreen an und ausschalten
    if (_isFirstBoot) {
      prefs.setBool('isFirstBoot', false);
      _isFirstBoot = false;

      Navigator.pushNamedAndRemoveUntil(context, '/intro', ModalRoute.withName('/intro'));
    } else {
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
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<void> updateData() async {
    await getAllLabels();
    await getAllVertraege();
  }
}
