import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterPopup extends StatelessWidget {
  Function onTap;

  FilterPopup({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.filter_alt_outlined,
          size: 30,
        ),
        tooltip: "Filter",
        itemBuilder: (context) {
          List<Label> labels = context.read<AllVertraegeProvider>().getAllLabels();
          labels.insert(0, Label(name: "Alle", colorValue: 0xFFFFFF));
          return List.generate(labels.length, (index) {
            return PopupMenuItem(
              child: Row(children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Color(labels[index].colorValue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Text(labels[index].name),
              ]),
              onTap: () {
                onTap(context, labels[index]);
                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                context.read<AllVertraegeProvider>().notifyListeners();
              },
            );
          });
        });
  }
}
