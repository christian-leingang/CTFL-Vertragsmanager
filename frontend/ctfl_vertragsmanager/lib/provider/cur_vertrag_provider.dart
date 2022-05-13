import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class cur_Vertrag_Provider with ChangeNotifier {
  String _cur_Vertrag_id = "-1";

  String get cur_Vertrag_id => _cur_Vertrag_id;

  void set_cur_Vertrag_id(String value) {
    this._cur_Vertrag_id = value;
    notifyListeners();
  }

  Future<Vertrag> get_cur_Vertrag() async {
    return await getHiveVertragById(cur_Vertrag_id);
  }

  void reset_cur_Vertrag_id() {
    this._cur_Vertrag_id = "-1";
    notifyListeners();
  }
}
