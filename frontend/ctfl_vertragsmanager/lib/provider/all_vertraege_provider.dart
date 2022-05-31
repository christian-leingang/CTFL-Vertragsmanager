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

  List<Vertrag> sortVertraegeByOption(String option, List<Vertrag> vertraege) {
    List<Vertrag> sortedVertraege = vertraege;
    switch (option) {
      case "Betrag":
        sortedVertraege.sort(((a, b) => a.beitrag.compareTo(b.beitrag)));
        break;
      case "nächste Zahlung":
        sortedVertraege.sort(((a, b) => a.naechsteZahlung == null
            ? 1
            : b.naechsteZahlung == null
                ? -1
                : a.naechsteZahlung!.compareTo(b.naechsteZahlung!)));
        break;
      default:
        sortedVertraege.sort(((a, b) => a.name.compareTo(b.name)));
        break;
    }
    return sortedVertraege;
  }

  List<Label> getAllLabels() {
    List<Label> labels = [];
    for (Vertrag vertrag in _vertraege) {
      if (!labels.contains(vertrag.label)) {
        labels.add(vertrag.label!);
      }
    }
    return labels;
  }
}
