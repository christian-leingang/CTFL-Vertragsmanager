import 'package:flutter/material.dart';

class DetailsTile extends StatelessWidget {
  String description;
  String value;

  DetailsTile({required this.description, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
          Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
