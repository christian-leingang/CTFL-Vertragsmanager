import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/foundation.dart';
import '../models/label.dart';

class AllVertraegeProvider with ChangeNotifier {
  List<Vertrag> _vertraege = [];

  List<Vertrag> get vertraege => _vertraege;

  void notifyOurListeners() {
    notifyListeners();
  }

  List<Vertrag> getAllVertraege() {
    _vertraege = HiveFunctions.getHiveVertraege().values.toList();
    return _vertraege;
  }

  List<Vertrag> getAllVertraegeByLabel(Label label) {
    List<Vertrag> filteredVertraege =
        _vertraege.where((element) => element.label == label).toList();
    return filteredVertraege;
  }

  List<Label> getAllLabels() {
    List<Label> labels = [];
    for (Vertrag vertrag in _vertraege) {
      if (!labels.contains(vertrag.label)) {
        labels.add(vertrag.label!);
      }
    }
    if (kDebugMode) {
      print(labels.length);
    }
    return labels;
  }
}
