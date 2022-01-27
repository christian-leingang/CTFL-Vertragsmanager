import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class new_Vertrag_Provider with ChangeNotifier {
  Vertrag newVertrag = Vertrag(name: "Neuer Vertrag", beitrag: 0.0);

  void addVertragName(String name) {
    newVertrag.name = name;
    notifyListeners();
  }

  void addVertragLabel(Label? label) {
    if (label != null) {
      newVertrag.label = label;
      notifyListeners();
    }
  }

  void addVertragBeschreibung(String? beschreibung) {
    if (beschreibung != null) {
      newVertrag.beschreibung = beschreibung;
      notifyListeners();
    }
  }

  void addVertragPartner(String? vertragspartner) {
    if (vertragspartner != null) {
      newVertrag.vertragspartner = vertragspartner;
      notifyListeners();
    }
  }

  void addVertragBeitrag(String? beitrag) {
    if (beitrag != null && beitrag != "".trim()) {
      newVertrag.beitrag = double.parse(beitrag);
      notifyListeners();
    }
  }

  void addVertragsBeginn(DateTime? vertragsBeginn) {
    if (vertragsBeginn != null) {
      newVertrag.vertragsBeginn = setDateFromDateTime(vertragsBeginn);
      notifyListeners();
    }
  }

  void addVertragEnde(DateTime? vertragsEnde) {
    if (vertragsEnde != null && vertragsEnde != "".trim()) {
      newVertrag.vertragsEnde = setDateFromDateTime(vertragsEnde);
      notifyListeners();
    }
  }

  void addVertragKuendigungsfrist(DateTime? kuendigungsfrist) {
    if (kuendigungsfrist != null && kuendigungsfrist != "".trim()) {
      newVertrag.kuendigungsfrist = setDateFromDateTime(kuendigungsfrist);
      notifyListeners();
    }
  }

  void addVertragIntervall(String? intervall) {
    if (intervall != null) {
      newVertrag.intervall = intervall;
      notifyListeners();
    }
  }

  void addVertragErstzahlung(DateTime? erstzahlung) {
    if (erstzahlung != null && erstzahlung != "".trim()) {
      newVertrag.erstZahlung = setDateFromDateTime(erstzahlung);
      notifyListeners();
    }
  }

  void reset_new_Vertrag() {
    newVertrag = Vertrag(name: "Neuer Vertrag", beitrag: 0.0);
  }
}
