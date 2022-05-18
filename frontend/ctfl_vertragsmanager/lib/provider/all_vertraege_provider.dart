import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

import '../models/label.dart';

class all_Vertraege_Provider with ChangeNotifier {
  List<Vertrag> _vertraege = [];

  List<Vertrag> get vertraege => _vertraege;

  void notifyOurListeners() {
    notifyListeners();
  }

  List<Vertrag> get_all_vertraege() {
    _vertraege = HiveFunctions.getHiveVertraege().values.toList();
    return _vertraege;
  }

  List<Vertrag> get_all_vertraege_by_Label(Label label) {
    List<Vertrag> filtered_vertraege =
        _vertraege.where((element) => element.label == label).toList();
    return filtered_vertraege;
  }

  List<Label> get_all_Labels() {
    List<Label> labels = [];
    for (Vertrag vertrag in _vertraege) {
      if (!labels.contains(vertrag.label)) {
        labels.add(vertrag.label!);
      }
    }
    print(labels.length);
    return labels;
  }
}
