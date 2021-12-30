import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:flutter/material.dart';

enum Intervall { woechentlich, monatlich, quartal, halbjaehrlich, jaehrlich }

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

  DateTime _vertragsBeginn;

  String getVertragsBeginn() => getDate(_vertragsBeginn);

  set vertragsBeginn(DateTime vertragsBeginn) {
    _vertragsBeginn = vertragsBeginn;
  }

  DateTime _vertragsEnde;

  String getVertragsEnde() => getDate(_vertragsEnde);

  set vertragsEnde(DateTime vertragsEnde) {
    _vertragsEnde = vertragsEnde;
  }

  DateTime _kuendigungsfrist;

  String getKuendigungsfrist() => getDate(_kuendigungsfrist);

  set kuendigungsfrist(DateTime kuendigungsfrist) {
    _kuendigungsfrist = kuendigungsfrist;
  }

  Intervall _intervall;

  String getIntervall() => _intervall.name;

  set intervall(Intervall intervall) {
    _intervall = intervall;
  }

  double _beitrag;

  double get beitrag => _beitrag;
  String getBeitragEuro() => _beitrag.toString() + " €";
  String getBeitragNumber() => _beitrag.toString();

  set beitrag(double beitrag) {
    _beitrag = beitrag;
  }

  DateTime _erstzahlung;

  String getErstzahlung() => getDate(_erstzahlung);

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
        _label = label ?? Label(name: "Streaming", color: Color(0xffAAAAAA)),
        _beschreibung = beschreibung ?? "",
        _vertragspartner = vertragspartner ?? "",
        _vertragsBeginn = vertragsBeginn ?? DateTime.now(),
        _vertragsEnde = vertragsEnde ?? DateTime.now(),
        _kuendigungsfrist = kuendigungsfrist ?? DateTime.now(),
        _intervall = intervall ?? Intervall.monatlich,
        _beitrag = beitrag ?? 9.99,
        _erstzahlung = erstZahlung ?? DateTime.now(),
        _naechsteZahlung = DateTime.now();
}
