import 'dart:io';

import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'calendar_utils.dart';

class HiveFunctions {
  static Box<Vertrag> getHiveVertraege() => Hive.box<Vertrag>('vertraege');
  static Box<Label> getHiveLabels() => Hive.box<Label>('labels');
}

List<Vertrag> getHiveAllVertraege() {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  List<Vertrag> vertraege = [];
  for (var vertrag in vertragsBox.values) {
    vertraege.add(vertrag);
  }
  return vertraege;
}

Future<Vertrag> getHiveVertragById(String vertragId) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  return vertragsBox.get(vertragId)!;
}

List<Event> getHiveVertraegeByDate(DateTime day) {
  List<Vertrag> vertraege = getHiveAllVertraege();
  List<Event> events = [];
  for (var vertrag in vertraege) {
    if (checkSameDay(vertrag.erstZahlung, day)) {
      events.add(Event("Erstzahlung ${vertrag.name}"));
    } else if (checkSameDay(vertrag.kuendigungsfrist, day)) {
      events.add(Event("Kündigungsfrist ${vertrag.name}"));
    }
    if (checkSameDay(vertrag.vertragsBeginn, day)) {
      events.add(Event("Vertragsbeginn ${vertrag.name}"));
    } else if (checkSameDay(vertrag.vertragsEnde, day)) {
      events.add(Event("Vertragsende ${vertrag.name}"));
    }
    print("Intervall: ${vertrag.intervall.toString()}");
    if (vertrag.intervall != null &&
        vertrag.erstZahlung != null &&
        vertrag.vertragsEnde != null &&
        vertrag.vertragsEnde!.isAfter(day)) {
      print("Zahltage");
      Event zahltag = getZahltagEvents(vertrag, day);
      if (zahltag.title != "keins") events.add(zahltag);
    }
  }
  return events;
}

Event getZahltagEvents(Vertrag vertrag, DateTime day) {
  if (vertrag.intervall == "wöchentlich" && vertrag.erstZahlung!.weekday == day.weekday) {
    return Event("Zahltag ${vertrag.name} ${vertrag.getBeitragEuro()}");
  } else if (vertrag.intervall == "monatlich" && checkLastDay(vertrag.erstZahlung!.day, day)) {
    return Event("Zahltag ${vertrag.name} ${vertrag.getBeitragEuro()}");
  } else if (vertrag.intervall == "quartal" &&
      checkLastDay(vertrag.erstZahlung!.day, day) &&
      day.month % 3 == vertrag.erstZahlung!.month % 3) {
    return Event("Zahltag ${vertrag.name} ${vertrag.getBeitragEuro()}");
  } else if (vertrag.intervall == "halbjährlich" &&
      checkLastDay(vertrag.erstZahlung!.day, day) &&
      day.month % 6 == vertrag.erstZahlung!.month % 6) {
    return Event("Zahltag ${vertrag.name} ${vertrag.getBeitragEuro()}");
  } else if (vertrag.intervall == "jährlich" &&
      checkLastDay(vertrag.erstZahlung!.day, day) &&
      day.month == vertrag.erstZahlung!.month) {
    return Event("Zahltag ${vertrag.name} ${vertrag.getBeitragEuro()}");
  }
  return const Event("keins");
}

bool checkLastDay(int vertragDay, DateTime todayDay) {
  final lastDayOfMonth = DateTime(todayDay.year, todayDay.month + 1, 0);

  if (vertragDay == todayDay.day) {
    return true;
  } else if (todayDay == lastDayOfMonth && vertragDay > todayDay.day) {
    return true;
  }
  return false;
}

bool checkSameDay(DateTime? vertragDay, DateTime day) {
  if (vertragDay?.day == day.day &&
      vertragDay?.month == day.month &&
      vertragDay?.year == day.year) {
    return true;
  }
  return false;
}

deleteHiveVertrag(String vertragsId) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  vertragsBox.delete(vertragsId);
}

createHiveVertrag(Vertrag vertrag) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  vertragsBox.put(vertrag.id, vertrag);
}

updateHiveVertrag(Vertrag vertrag) async {
  deleteHiveVertrag(vertrag.id!);
  createHiveVertrag(vertrag);
}

deleteHiveAllVertraege() async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  int vertragsLength = vertragsBox.length;

  for (var i = 0; i < vertragsLength; i++) {
    vertragsBox.deleteAt(0);
  }
}

updateHiveAllVertraege(List<Vertrag> vertraege) async {
  deleteHiveAllVertraege();
  final vertragsBox = HiveFunctions.getHiveVertraege();
  for (int i = 0; i < vertraege.length; i++) {
    vertragsBox.put(vertraege[i].id, vertraege[i]);
  }
}

Label getHiveLabelByName(String labelName) {
  final labelBox = HiveFunctions.getHiveLabels();

  for (int i = 0; i < labelBox.length; i++) {
    if (labelBox.getAt(i)?.name == labelName) {
      return labelBox.getAt(i)!;
    }
  }
  return labelBox.getAt(0)!;
}

Future<List<Label>> getHiveAllLabels() async {
  final labelBox = HiveFunctions.getHiveLabels();
  List<Label> labels = [];
  for (int i = 0; i < labelBox.length; i++) {
    labels.add(labelBox.getAt(i)!);
  }

  return labels;
}

addHiveLabel(Label newLabel) async {
  final labelBox = HiveFunctions.getHiveLabels();
  labelBox.add(newLabel);
}

deleteHiveAllLabels() {
  final labelBox = HiveFunctions.getHiveLabels();
  int labelLength = labelBox.length;
  for (var i = 0; i < labelLength; i++) {
    labelBox.deleteAt(0);
  }
}

updateHiveAllLabels(List<Label> labels) {
  deleteHiveAllLabels();
  final labelBox = HiveFunctions.getHiveLabels();
  for (int i = 0; i < labels.length; i++) {
    labelBox.add(labels[i]);
  }
}

clearHive() async {
  deleteHiveAllLabels();
  deleteHiveAllVertraege();

  // Get the application's document directory
  var appDir = await getApplicationDocumentsDirectory();

  // Get the chosen sub-directory for Hive files
  var hiveDb = Directory('${appDir.path}/chosenPath');

  // Delete the Hive directory and all its files
  hiveDb.delete(recursive: true);
}
