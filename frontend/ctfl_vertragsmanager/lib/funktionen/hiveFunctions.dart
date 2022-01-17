import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HiveFunctions {
  static Box<Vertrag> getHiveVertraege() => Hive.box<Vertrag>('vertraege');
  static Box<Label> getHiveLabels() => Hive.box<Label>('labels');
}

Future<List<Vertrag>?> getHiveAllVertraege() async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  List<Vertrag>? vertraege;
  for (var vertrag in vertragsBox.values) {
    vertraege!.add(vertrag);
  }
  return vertraege;
}

Future<Vertrag?> getHiveVertragById(String vertragId) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  vertragsBox.get(vertragId);
}

deleteHiveVertrag(String vertragsId) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  vertragsBox.delete(vertragsId);
}

createHiveVertrag(Vertrag vertrag) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  vertragsBox.put(vertrag.id, vertrag);
}

deleteHiveAllVertraege() async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  for (var i = 0; i < vertragsBox.length; i++) {
    vertragsBox.deleteAt(i);
  }
}

createHiveAllVertraege(List<Vertrag> vertraege) async {
  final vertragsBox = HiveFunctions.getHiveVertraege();
  for (int i = 0; i < vertraege.length; i++) {
    vertragsBox.put(vertraege[i].id, vertraege[i]);
  }
}

Future<Label> getLabelByName(String labelName) async {
  final labelBox = HiveFunctions.getHiveLabels();
  for (int i = 0; i < labelBox.length; i++) {
    if (labelBox.get(i)!.name == labelName) {
      return labelBox.get(i)!;
    }
  }
  return labelBox.get(0)!;
}

addLabel(Label newLabel) async {
  final labelBox = HiveFunctions.getHiveLabels();
  labelBox.put(labelBox.length, newLabel);
}
