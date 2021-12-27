import 'package:flutter/material.dart';

import 'label.dart';

class Labels {
  static var _labels = [
    Label(color: Colors.red, name: "Streaming"),
    Label(color: Colors.green, name: "Musik"),
    Label(color: Colors.blue, name: "Auto"),
    Label(color: Colors.purple, name: "Sachversicherung"),
    Label(color: Colors.orange, name: "Lebensversicherung"),
  ];

  static Label getLabel(int labelId) {
    return _labels[labelId];
  }

  List<Label> get labels {
    return _labels;
  }
}
