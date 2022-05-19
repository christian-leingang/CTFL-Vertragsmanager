import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/sort.dart';
import 'package:ctfl_vertragsmanager/partials/vertrag_card.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/new_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../partials/filter.dart';

class VertraegePage extends StatelessWidget {
  VertraegePage({Key? key}) : super(key: key);
  // final vertragsBox = HiveFunctions.getHiveVertraege();
  late List<Vertrag> vertraege;

  filterVertraege(BuildContext context, Label selectedLabel) {
    if (selectedLabel.name == "Alle") {
      return vertraege = context.read<AllVertraegeProvider>().getAllVertraege();
    }
    return vertraege = context.read<AllVertraegeProvider>().getAllVertraegeByLabel(selectedLabel);
  }

  sortVertraege(BuildContext context, String selectedOption, List<Vertrag> vertraege) {
    vertraege =
        context.read<AllVertraegeProvider>().sortVertraegeByOption(selectedOption, vertraege);
  }

  @override
  Widget build(BuildContext context) {
    vertraege = context.read<AllVertraegeProvider>().getAllVertraege();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Image(image: AssetImage('assets/logo.jpg')),
        title: const Text(
          "Verträge",
        ),
        actions: [
          FilterPopup(onTap: filterVertraege),
          SortPopup(onTap: sortVertraege, vertraege: vertraege),
        ],
      ),
      body: vertraege.isEmpty
          ? const Text("")
          : Consumer<AllVertraegeProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: vertraege.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VertragCardPage(
                      key: Key(UniqueKey().toString()),
                      vertrag: vertraege[index],
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NewVertragProvider>().resetNewVertrag();
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
