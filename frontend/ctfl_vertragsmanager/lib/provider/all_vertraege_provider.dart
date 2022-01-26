import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class all_Vertraege_Provider with ChangeNotifier {
  List<Vertrag> _vertraege = [];

  List<Vertrag> get vertraege => _vertraege;

  void notifyOurListeners() {
    notifyListeners();
  }

  List<Vertrag> get_all_vertraege() {
    return getHiveAllVertraege();
  }
}
