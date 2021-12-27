import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/vertragscard.dart';
import 'package:flutter/material.dart';

//TODO: Farben als Hex-Code?

// ignore: must_be_immutable
class VertraegePage extends StatelessWidget {
  VertraegePage({Key? key}) : super(key: key);
  List<Vertrag> vertraege = Vertragsdaten().vertraege;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: vertraege.length,
          itemBuilder: (BuildContext context, int index) {
            return VertragsCardPage(
              name: vertraege[index].name,
              price: vertraege[index].beitrag,
              date: vertraege[index].getNaechsteZahlung(),
              label: vertraege[index].label,
            );
          },
        ),

        // +-Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: const Color(0xffD72324),
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
      );

  //   Container(
  //     child: VertragsCardPage(
  //         name: "Netflix", price: 9.99, date: "07.12.2021", label: "Unterhaltung"),
  //   ),
  // );
}
