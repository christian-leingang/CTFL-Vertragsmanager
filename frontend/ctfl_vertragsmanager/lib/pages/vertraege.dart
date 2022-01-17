import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/vertragscard.dart';
import 'package:ctfl_vertragsmanager/provider/vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/src/provider.dart';

//TODO: Farben als Hex-Code?

// ignore: must_be_immutable
class VertraegePage extends StatelessWidget {
  VertraegePage({Key? key}) : super(key: key);
  final vertragsBox = HiveFunctions.getHiveVertraege();
  late List<Vertrag> vertraege = vertragsBox.values.toList().cast<Vertrag>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: vertraege.length,
        itemBuilder: (BuildContext context, int index) {
          return VertragsCardPage(
            name: vertraege[index].name,
            price: vertraege[index].beitrag,
            date: vertraege[index].getNaechsteZahlung(),
            label: vertraege[index].label,
            vertragsId: index,
          );
        },
      ),

      // +-Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/vertragHinzufuegen');
        },
        backgroundColor: ColorThemes.primaryColor,
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
    );
  }
}
