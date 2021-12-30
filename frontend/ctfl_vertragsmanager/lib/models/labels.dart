import 'package:flutter/material.dart';

import 'label.dart';

class Labels {
  static var _labels = [
    Label(name: "Label", color: Colors.pink),
    Label(color: Colors.red, name: "Streaming"),
    Label(color: Colors.green, name: "Musik"),
    Label(color: Colors.blue, name: "Auto"),
    Label(color: Colors.purple, name: "Sachversicherung"),
    Label(color: Colors.orange, name: "Lebensversicherung"),
  ];

  static Label getLabel(int labelId) {
    return _labels[labelId];
  }

  static List<Label> get labels {
    return _labels;
  }

  static List<String> getLabelsString() {
    List<String> string_values = [];
    for (var label in _labels) {
      string_values.add(label.name);
    }
    return string_values;
  }
}
