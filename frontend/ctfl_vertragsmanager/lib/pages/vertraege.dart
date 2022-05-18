import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/vertragCard.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/new_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../partials/filter.dart';

class VertraegePage extends StatelessWidget {
  VertraegePage({Key? key}) : super(key: key);
  // final vertragsBox = HiveFunctions.getHiveVertraege();
  late List<Vertrag> vertraege;

  filter_Vertraege(BuildContext context, Label selected_label) {
    if (selected_label.name == "Alle") {
      return vertraege = context.read<all_Vertraege_Provider>().get_all_vertraege();
    }
    return vertraege =
        context.read<all_Vertraege_Provider>().get_all_vertraege_by_Label(selected_label);
  }

  @override
  Widget build(BuildContext context) {
    vertraege = context.read<all_Vertraege_Provider>().get_all_vertraege();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Image(image: AssetImage('assets/logo.jpg')),
        title: const Text(
          "Verträge",
        ),
        actions: [
          FilterPopup(onTap: filter_Vertraege),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.import_export_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: vertraege.length == 0
          ? Text("")
          : Consumer<all_Vertraege_Provider>(
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
