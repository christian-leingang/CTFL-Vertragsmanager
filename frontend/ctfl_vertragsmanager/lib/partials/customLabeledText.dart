import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  String description;
  String value;
  Color lineColor;

  DetailsTile({required this.description, required this.value, required this.lineColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
          Divider(
            color: lineColor.withOpacity(0.7),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
