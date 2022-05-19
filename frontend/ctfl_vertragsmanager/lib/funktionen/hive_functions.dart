import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:hive_flutter/adapters.dart';

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