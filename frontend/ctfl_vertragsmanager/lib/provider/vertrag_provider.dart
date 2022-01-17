import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class Vertrag_Provider with ChangeNotifier {
  Vertrag _newVertrag = Vertrag(name: "Neuer Vertrag");

  Vertrag get newVertrag {
    return _newVertrag;
  }

  void addVertragName(String name) {
    _newVertrag.name = name;
    notifyListeners();
  }

  void addVertragLabel(Label? label) {
    if (label != null) {
      _newVertrag.label = label;
      notifyListeners();
    }
  }

  void addVertragBeschreibung(String? beschreibung) {
    if (beschreibung != null) {
      _newVertrag.beschreibung = beschreibung;
      notifyListeners();
    }
  }

  void addVertragPartner(String? vertragspartner) {
    if (vertragspartner != null) {
      _newVertrag.vertragspartner = vertragspartner;
      notifyListeners();
    }
  }

  void addVertragBeitrag(String? beitrag) {
    if (beitrag != null && beitrag != "".trim()) {
      _newVertrag.beitrag = double.parse(beitrag);
      notifyListeners();
    }
  }

  void addVertragsBeginn(DateTime? vertragsBeginn) {
    if (vertragsBeginn != null) {
      print("Beginn: " + vertragsBeginn.toString());
      _newVertrag.vertragsBeginn = vertragsBeginn;
      notifyListeners();
    }
  }

  void addVertragEnde(String? vertragsEnde) {
    if (vertragsEnde != null && vertragsEnde != "".trim()) {
      _newVertrag.vertragsEnde = setDate(vertragsEnde);
      notifyListeners();
    }
  }

  void addVertragKuendigungsfrist(String? kuendigungsfrist) {
    if (kuendigungsfrist != null && kuendigungsfrist != "".trim()) {
      _newVertrag.kuendigungsfrist = setDate(kuendigungsfrist);
      notifyListeners();
    }
  }

  void addVertragIntervall(String? intervall) {
    if (intervall != null) {
      _newVertrag.intervall = intervall;
      notifyListeners();
    }
  }

  void addVertragErstzahlung(String? erstzahlung) {
    if (erstzahlung != null && erstzahlung != "".trim()) {
      _newVertrag.erstzahlung = setDate(erstzahlung);
      notifyListeners();
    }
  }
}
