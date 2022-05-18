import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/vertragCard.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:ctfl_vertragsmanager/provider/new_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/src/provider.dart';

//TODO: Farben als Hex-Code?

// ignore: must_be_immutable
class VertraegePage extends StatelessWidget {
  VertraegePage({Key? key}) : super(key: key);
  // final vertragsBox = HiveFunctions.getHiveVertraege();
  late List<Vertrag> vertraege;

  @override
  Widget build(BuildContext context) {
    vertraege = context.watch<all_Vertraege_Provider>().get_all_vertraege();

    for (var vertrag in vertraege) {}

    return Scaffold(
      body: vertraege.length == 0
          ? Text("")
          : ListView.builder(
              itemCount: vertraege.length,
              itemBuilder: (BuildContext context, int index) {
                return VertragCardPage(
                  vertrag: vertraege[index],
                );
              },
            ),

      // +-Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<new_Vertrag_Provider>().reset_new_Vertrag();
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
