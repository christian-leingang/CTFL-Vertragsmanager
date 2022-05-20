import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'label.g.dart';

@HiveType(typeId: 1)
class Label {
  @HiveField(0)
  String name;
  @HiveField(1)
  int colorValue;
  get getName => name;

  set setName(name) => this.name = name;

  get getColorName => colorValue;

  set setColorName(color) => colorValue = color;

  Label({required this.name, required this.colorValue});
}
