import 'package:ctfl_vertragsmanager/models/label.dart';

class Vertrag {
  String name;
  double price;
  String date;
  Label label;

  Vertrag({required this.name, required this.date, required this.label, required this.price});

  get getName => this.name;

  set setName(String name) => this.name = name;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLabel => this.label;

  set setLabel(label) => this.label = label;
}
