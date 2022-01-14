import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:hive_flutter/adapters.dart';

class HiveFunctions {
  static Box<Vertrag> getHiveVertraege() => Hive.box<Vertrag>('vertraege');
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
