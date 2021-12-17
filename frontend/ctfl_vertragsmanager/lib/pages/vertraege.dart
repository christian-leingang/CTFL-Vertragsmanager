import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/vertragsCard.dart';
import 'package:flutter/material.dart';

//TODO: Farben als Hex-Code?

var labels = [
  Label(color: Colors.red, name: "Streaming"),
  Label(color: Colors.green, name: "Musik"),
  Label(color: Colors.blue, name: "Auto"),
  Label(color: Colors.purple, name: "Sachversicherung"),
  Label(color: Colors.orange, name: "Lebensversicherung"),
];

class VertraegePage extends StatelessWidget {
  var vertraege = [
    Vertrag(name: "Netflix", price: 12.99, date: "07.12.2021", label: labels[0]),
    Vertrag(name: "Spotify", price: 9.99, date: "07.12.2021", label: labels[1]),
    Vertrag(name: "Kfz-Haftpflicht", price: 30.99, date: "07.12.2021", label: labels[2]),
    Vertrag(name: "Vollkasko", price: 25.99, date: "07.12.2021", label: labels[2]),
    Vertrag(name: "Hausrat", price: 17.99, date: "07.12.2021", label: labels[3]),
    Vertrag(name: "Berufsunfähigkeit", price: 40.99, date: "07.12.2021", label: labels[4]),
    Vertrag(name: "Netflix", price: 9.99, date: "07.12.2021", label: labels[0]),
    Vertrag(name: "Netflix", price: 9.99, date: "07.12.2021", label: labels[0]),
    Vertrag(name: "Netflix", price: 9.99, date: "07.12.2021", label: labels[0]),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: new ListView.builder(
          itemCount: vertraege.length,
          itemBuilder: (BuildContext context, int index) {
            return new VertragsCardPage(
              name: vertraege[index].getName,
              price: vertraege[index].getPrice,
              date: vertraege[index].getDate,
              label: vertraege[index].getLabel,
            );
          },
        ),

        // +-Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Color(0xffD72324),
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      );

  //   Container(
  //     child: VertragsCardPage(
  //         name: "Netflix", price: 9.99, date: "07.12.2021", label: "Unterhaltung"),
  //   ),
  // );
}
