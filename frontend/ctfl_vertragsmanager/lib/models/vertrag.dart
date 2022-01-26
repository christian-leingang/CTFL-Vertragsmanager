import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part "vertrag.g.dart";

//enum Intervall { woechentlich, monatlich, quartal, halbjaehrlich, jaehrlich }
List<String> Intervall = [
  "wöchentlich",
  "monatlich",
  "quartal",
  "halbjährlich",
  "jährlich",
];

@HiveType(typeId: 0)
class Vertrag extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  Label? label;

  @HiveField(3)
  String? beschreibung;

  @HiveField(4)
  String? vertragspartner;

  @HiveField(5)
  DateTime? vertragsBeginn;

  @HiveField(6)
  DateTime? vertragsEnde;

  @HiveField(7)
  DateTime? kuendigungsfrist;

  @HiveField(8)
  String? intervall;

  @HiveField(9)
  double beitrag;

  @HiveField(10)
  DateTime? erstZahlung;

  @HiveField(11)
  DateTime? naechsteZahlung;

  Vertrag({
    required this.name,
    required this.beitrag,
    this.id,
    this.label,
    this.beschreibung,
    this.vertragspartner,
    this.vertragsBeginn,
    this.vertragsEnde,
    this.kuendigungsfrist,
    this.intervall,
    this.erstZahlung,
  });

  Vertrag.fromJson(
    // required this.id,
    Map<String, dynamic> json,
  )   : id = json["contractId"],
        name = json["name"],
        beschreibung = json["description"] != null ? json["description"] : "",
        vertragspartner = json["vertragspartner"],
        vertragsBeginn = json["vertragsBeginn"] != null ? setDate(json["vertragsBeginn"]) : null,
        vertragsEnde = json["vertragsEnde"] != null ? setDate(json["vertragsEnde"]) : null,
        kuendigungsfrist =
            json["kuendigungsfrist"] != null ? setDate(json["kuendigungsfrist"]) : null,
        intervall = json["intervall"],
        beitrag = json["beitrag"].toDouble(),
        erstZahlung = json["erstZahlung"] != null ? setDate(json["erstZahlung"]) : null,
        naechsteZahlung = json["naechsteZahlung"] != null ? setDate(json["naechsteZahlung"]) : null;

  get asJson => {
        "name": name,
        if (getLabelName() != null) "labelName": getLabelName(),
        if (beschreibung != null) "description": beschreibung,
        if (intervall != null) "intervall": intervall,
        "beitrag": getBeitragNumber(),
        if (getVertragsBeginn() != null) "vertragsBeginn": getVertragsBeginn(),
        if (getVertragsEnde() != null) "vertragsEnde": getVertragsEnde(),
        if (getKuendigungsfrist() != null) "kuendigungsfrist": getKuendigungsfrist(),
        if (getErstzahlung() != null) "erstZahlung": getErstzahlung(),
      };

  String getDate(DateTime dateTime) {
    return dateTime.day.toString() +
        "." +
        dateTime.month.toString() +
        "." +
        dateTime.year.toString();
  }

  String? getLabelName() {
    if (label != null) {
      return label!.name;
    }
    return null;
  }

  String? getVertragsBeginn() {
    if (vertragsBeginn != null) {
      return getDate(vertragsBeginn!);
    } else
      return null;
  }

  String? getVertragsEnde() {
    if (vertragsEnde != null) {
      return getDate(vertragsEnde!);
    } else
      return null;
  }

  String? getKuendigungsfrist() {
    if (kuendigungsfrist != null) {
      return getDate(kuendigungsfrist!);
    } else
      return null;
  }

  static List<String> getAllIntervalle() => Intervall;

  String? getBeitragEuro() {
    if (beitrag != null) {
      return beitrag.toString() + " €";
    } else
      return null;
  }

  String? getBeitragNumber() {
    if (beitrag != null) {
      return beitrag.toString();
    } else
      return null;
  }

  String? getErstzahlung() {
    if (erstZahlung != null) {
      return getDate(erstZahlung!);
    } else
      return null;
  }

  String? getNaechsteZahlung() {
    if (naechsteZahlung != null) return getDate(naechsteZahlung!);
    return "";
  }
}

DateTime setDate(String dateAsString) {
  debugPrint("DateAsString" + dateAsString);
  List<String> dateSplitted = dateAsString.split("-");
  return DateTime(
      int.parse(dateSplitted[2]), int.parse(dateSplitted[1]), int.parse(dateSplitted[0]));
}

DateTime setDateFromDateTime(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
