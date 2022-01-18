import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part "vertrag.g.dart";

//enum Intervall { keins, woechentlich, monatlich, quartal, halbjaehrlich, jaehrlich }
List<String> Intervall = [
  "kein Intervall",
  "wöchentlich",
  "monatlich",
  "quartal",
  "halbjährlich",
  "jährlich",
];

@HiveType(typeId: 0)
class Vertrag extends HiveObject {
  @HiveField(0)
  String? _id;

  String? get id => this._id;

  set id(String? value) => this._id = value;

  String getDate(DateTime dateTime) {
    return dateTime.day.toString() +
        "." +
        dateTime.month.toString() +
        "." +
        dateTime.year.toString();
  }

  @HiveField(1)
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  @HiveField(2)
  Label _label;

  String getLabelName() => _label.name;

  Label get label => _label;

  set label(Label label) {
    _label = label;
  }

  @HiveField(3)
  String _beschreibung;

  String get beschreibung => _beschreibung;

  set beschreibung(String beschreibung) {
    _beschreibung = beschreibung;
  }

  @HiveField(4)
  String _vertragspartner;

  String get vertragspartner => _vertragspartner;

  set vertragspartner(String vertragspartner) {
    _vertragspartner = vertragspartner;
  }

  @HiveField(5)
  DateTime? _vertragsBeginn;

  String getVertragsBeginn() {
    if (_vertragsBeginn != null) {
      return getDate(_vertragsBeginn!);
    } else
      return "";
  }

  set vertragsBeginn(DateTime vertragsBeginn) {
    _vertragsBeginn = vertragsBeginn;
  }

  @HiveField(6)
  DateTime? _vertragsEnde;

  String getVertragsEnde() {
    if (_vertragsEnde != null) {
      return getDate(_vertragsEnde!);
    } else
      return "";
  }

  set vertragsEnde(DateTime vertragsEnde) {
    _vertragsEnde = vertragsEnde;
  }

  @HiveField(7)
  DateTime? _kuendigungsfrist;

  String getKuendigungsfrist() {
    if (_kuendigungsfrist != null) {
      return getDate(_kuendigungsfrist!);
    } else
      return "";
  }

  set kuendigungsfrist(DateTime kuendigungsfrist) {
    _kuendigungsfrist = kuendigungsfrist;
  }

  @HiveField(8)
  String _intervall;

  String get intervall => _intervall;

  static List<String> getAllIntervalle() => Intervall;

  set intervall(String intervall) {
    _intervall = intervall;
  }

  @HiveField(9)
  double? _beitrag;

  double get beitrag {
    if (_beitrag != null) {
      return _beitrag!;
    } else
      return 0;
  }

  String getBeitragEuro() {
    if (_beitrag != null) {
      return _beitrag.toString() + " €";
    } else
      return "";
  }

  String getBeitragNumber() {
    if (_beitrag != null) {
      return _beitrag.toString();
    } else
      return "";
  }

  set beitrag(double beitrag) {
    _beitrag = beitrag;
  }

  @HiveField(10)
  DateTime? _erstzahlung;

  String getErstzahlung() {
    if (_erstzahlung != null) {
      return getDate(_erstzahlung!);
    } else
      return "";
  }

  set erstzahlung(DateTime erstzahlung) {
    _erstzahlung = erstzahlung;
  }

  @HiveField(11)
  DateTime _naechsteZahlung;

  String getNaechsteZahlung() => getDate(_naechsteZahlung);

  set naechsteZahlung(DateTime naechsteZahlung) {
    _naechsteZahlung = naechsteZahlung;
  }

  Vertrag({
    name,
    id,
    label,
    beschreibung,
    vertragspartner,
    vertragsBeginn,
    vertragsEnde,
    kuendigungsfrist,
    intervall,
    beitrag,
    erstZahlung,
  })  : _id = id,
        _name = name,
        //TODO: Change to Label auswählen
        _label = label ?? Label(name: "kein Label", colorValue: Colors.white.value),
        _beschreibung = beschreibung ?? "",
        _vertragspartner = vertragspartner ?? "",
        _vertragsBeginn = vertragsBeginn,
        _vertragsEnde = vertragsEnde,
        _kuendigungsfrist = kuendigungsfrist,
        _intervall = intervall ?? "kein Intervall",
        _beitrag = beitrag,
        _erstzahlung = erstZahlung,
        _naechsteZahlung = DateTime.now();
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
