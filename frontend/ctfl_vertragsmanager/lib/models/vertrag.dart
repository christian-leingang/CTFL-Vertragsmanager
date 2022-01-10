import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:flutter/material.dart';

//enum Intervall { keins, woechentlich, monatlich, quartal, halbjaehrlich, jaehrlich }
List<String> Intervall = [
  "kein Intervall",
  "wöchentlich",
  "monatlich",
  "quartal",
  "halbjährlich",
  "jährlich",
];

class Vertrag {
  int _id;

  int get id => this._id;

  set id(int value) => this._id = value;

  String getDate(DateTime dateTime) {
    return dateTime.day.toString() +
        "." +
        dateTime.month.toString() +
        "." +
        dateTime.year.toString();
  }

  DateTime setDate(String dateAsString) {
    List<String> dateSplitted = dateAsString.split(".");
    return DateTime(
        int.parse(dateSplitted[2]), int.parse(dateSplitted[1]), int.parse(dateSplitted[0]));
  }

  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  Label _label;

  String getLabelName() => _label.name;

  Label get label => _label;

  set label(Label label) {
    _label = label;
  }

  String _beschreibung;

  String get beschreibung => _beschreibung;

  set beschreibung(String beschreibung) {
    _beschreibung = beschreibung;
  }

  String _vertragspartner;

  String get vertragspartner => _vertragspartner;

  set vertragspartner(String vertragspartner) {
    _vertragspartner = vertragspartner;
  }

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

  String _intervall;

  String get intervall => _intervall;

  static List<String> getAllIntervalle() => Intervall;

  set intervall(String intervall) {
    _intervall = intervall;
  }

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

  DateTime _naechsteZahlung;

  String getNaechsteZahlung() => getDate(_naechsteZahlung);

  set naechsteZahlung(DateTime naechsteZahlung) {
    _naechsteZahlung = naechsteZahlung;
  }

  Vertrag({
    required name,
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
  })  : _id = id ?? Vertragsdaten().vertraege.last.id + 1,
        _name = name,
        //TODO: Change to Label auswählen
        _label = label ?? Label(name: "kein Label", color: Colors.white),
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
