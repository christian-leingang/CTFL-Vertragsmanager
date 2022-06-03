import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VertragCardPage extends StatelessWidget {
  Vertrag vertrag;
  Function callback;

  VertragCardPage({Key? key, required this.vertrag, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vertrag.label != null) {}
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            context.read<CurVertragProvider>().setCurVertragId(vertrag.id!);
            callback();
          },
          child: Card(
            borderOnForeground: true,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vertrag.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vertrag.getBeitragEuro(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      vertrag.label != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color(vertrag.label!.colorValue),
                                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                                  child: Text(
                                    vertrag.label!.name,
                                    style: TextStyle(
                                        color: ThemeData.estimateBrightnessForColor(
                                                    Color(vertrag.label!.colorValue)) ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                            )
                          : const Text(""),
                      Text(
                        vertrag.getKuendigungsfrist() ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
