import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class CurVertragProvider with ChangeNotifier {
  String _curVertragId = "-1";

  String get curVertragId => _curVertragId;

  void setCurVertragId(String value) {
    _curVertragId = value;
    notifyListeners();
  }

  Future<Vertrag> getCurVertrag() async {
    return await getHiveVertragById(curVertragId);
  }

  void resetCurVertragId() {
    _curVertragId = "-1";
    notifyListeners();
  }
}
