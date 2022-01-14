import 'package:ctfl_vertragsmanager/models/labels.dart';
import 'package:flutter/material.dart';
import 'vertrag.dart';

class Vertragsdaten {
  final _vertraege = [
    Vertrag(
      id: "0",
      name: "Amazon Prime",
      beitrag: 12.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(0),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'Amazon',
    ),
    Vertrag(
      id: "1",
      name: "Netflix",
      beschreibung: "Beschreibung",
      beitrag: 12.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(0),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'Netflix',
    ),
    Vertrag(
      id: "2",
      name: "Spotify",
      beschreibung: "Beschreibung",
      beitrag: 9.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(1),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'Spotify',
    ),
    Vertrag(
      id: "3",
      name: "Kfz-Haftpflicht",
      beschreibung: "Beschreibung",
      beitrag: 30.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(2),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'SV SparkassenVersicherung',
    ),
    Vertrag(
      id: "4",
      name: "Vollkasko",
      beschreibung: "Beschreibung",
      beitrag: 25.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(2),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'SV SparkassenVersicherung',
    ),
    Vertrag(
      id: "5",
      name: "Hausrat",
      beschreibung: "Beschreibung",
      beitrag: 17.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(3),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'SV SparkassenVersicherung',
    ),
    Vertrag(
      id: "6",
      name: "Berufsunfähigkeit",
      beschreibung: "Beschreibung",
      beitrag: 40.99,
      erstZahlung: DateTime(2020, 12, 2),
      label: Labels.getLabel(4),
      intervall: "monatlich",
      kuendigungsfrist: DateTime(2020, 12, 2),
      vertragsBeginn: DateTime(2020, 12, 2),
      vertragsEnde: DateTime(2020, 12, 2),
      vertragspartner: 'SV SparkassenVersicherung',
    ),
    Vertrag(
      id: "7",
      name: "Netflix",
      label: Labels.getLabel(0),
      beschreibung: "Beispiel",
      vertragspartner: "Netflix",
      vertragsBeginn: DateTime(2022, 01, 01),
      vertragsEnde: DateTime(2023, 01, 01),
      kuendigungsfrist: DateTime(2022, 12, 01),
      intervall: "quartal",
      beitrag: 12.50,
      erstZahlung: DateTime(2022, 12, 01),
    ),
    Vertrag(
      id: "8",
      name: "Netflix",
      label: Labels.getLabel(0),
      beschreibung: "Beispiel",
      vertragspartner: "Netflix",
      vertragsBeginn: DateTime(2022, 01, 01),
      vertragsEnde: DateTime(2023, 01, 01),
      kuendigungsfrist: DateTime(2022, 12, 01),
      intervall: "quartal",
      beitrag: 12.50,
      erstZahlung: DateTime(2022, 12, 01),
    ),
    Vertrag(
      id: "9",
      name: "NetflixLeer",
    ),
  ];

  List<Vertrag> get vertraege {
    return _vertraege;
  }

  Vertrag getVertragById(String id) => _vertraege.firstWhere((element) => element.id == id);

  void removeVertrag(Vertrag vertrag) =>
      _vertraege.removeWhere((element) => element.id == vertrag.id);

  void saveVertrag(Vertrag vertrag) {
    if (_vertraege.any((element) => element.id == vertrag.id)) {
      removeVertrag(vertrag);
    }
    _vertraege.add(vertrag);
  }
}
