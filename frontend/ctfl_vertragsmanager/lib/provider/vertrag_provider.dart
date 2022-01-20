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
      _newVertrag.vertragsBeginn = setDateFromDateTime(vertragsBeginn);
      notifyListeners();
    }
  }

  void addVertragEnde(DateTime? vertragsEnde) {
    if (vertragsEnde != null && vertragsEnde != "".trim()) {
      _newVertrag.vertragsEnde = setDateFromDateTime(vertragsEnde);
      notifyListeners();
    }
  }

  void addVertragKuendigungsfrist(DateTime? kuendigungsfrist) {
    if (kuendigungsfrist != null && kuendigungsfrist != "".trim()) {
      _newVertrag.kuendigungsfrist = setDateFromDateTime(kuendigungsfrist);
      notifyListeners();
    }
  }

  void addVertragIntervall(String? intervall) {
    if (intervall != null) {
      _newVertrag.intervall = intervall;
      notifyListeners();
    }
  }

  void addVertragErstzahlung(DateTime? erstzahlung) {
    if (erstzahlung != null && erstzahlung != "".trim()) {
      _newVertrag.erstzahlung = setDateFromDateTime(erstzahlung);
      notifyListeners();
    }
  }
}
