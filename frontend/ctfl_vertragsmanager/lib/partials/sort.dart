import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/all_vertraege_provider.dart';

class SortPopup extends StatelessWidget {
  Function onTap;
  List<Vertrag> vertraege;

  SortPopup({Key? key, required this.onTap, required this.vertraege}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.import_export,
          size: 30,
        ),
        tooltip: "Filter",
        itemBuilder: (context) {
          List<String> options = ["Name", "Beitrag", "nächste Zahlung"];
          return List.generate(options.length, (index) {
            return PopupMenuItem(
              child: Row(children: [
                Text(options[index]),
              ]),
              onTap: () {
                onTap(context, options[index], vertraege);
                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                context.read<AllVertraegeProvider>().notifyListeners();
              },
            );
          });
        });
  }
}
