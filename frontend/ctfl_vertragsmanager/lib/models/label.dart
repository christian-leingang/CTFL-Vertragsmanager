import 'package:flutter/material.dart';

class Label {
  String name;
  Color color;
  get getName => name;

  set setName(name) => this.name = name;

  get getColor => color;

  set setColor(color) => this.color = color;

  Label({required this.name, required this.color});
}
