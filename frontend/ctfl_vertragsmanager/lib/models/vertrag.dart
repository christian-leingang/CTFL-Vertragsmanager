import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:flutter/material.dart';

enum Intervall { woechentlich, monatlich, quartal, jaehrlich }

class Vertrag {
  String getDate(DateTime dateTime) {
    return dateTime.day.toString() +
        "." +
        dateTime.month.toString() +
        "." +
        dateTime.year.toString();
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

  String _description;

  String get description => _description;

  set description(String description) {
    _description = description;
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
    required String name,
    required Label label,
    required String description,
    required String vertragspartner,
    required DateTime vertragsBeginn,
    required DateTime vertragsEnde,
    required DateTime kuendigungsfrist,
    required Intervall intervall,
    required double beitrag,
    required DateTime erstZahlung,
    required DateTime naechsteZahlung,
  })  : _name = name,
        _label = label,
        _description = description,
        _vertragspartner = vertragspartner,
        _vertragsBeginn = vertragsBeginn,
        _vertragsEnde = vertragsEnde,
        _kuendigungsfrist = kuendigungsfrist,
        _intervall = intervall,
        _beitrag = beitrag,
        _erstzahlung = erstZahlung,
        _naechsteZahlung = naechsteZahlung;
}
