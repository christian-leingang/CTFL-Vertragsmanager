import 'package:flutter/material.dart';

String name = "Max Mustermann";
String email = "max.mustermann@xyz.de";
String passwort = "********";

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(40),
              child: const Icon(
                Icons.account_circle_outlined,
                size: 150,
              ),
            ),
            Column(
              children: [
                const Text("Name:"),
                Text(
                  name,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const Text("E-Mail:"),
                Text(
                  email,
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Konto löschen"),
                style: TextButton.styleFrom(backgroundColor: const Color(0xffD72324)),
              ),
            ),
          ],
        ),
      ),
      // +-Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: const Color(0xffD72324),
        child: const Icon(
          Icons.edit,
          size: 25,
        ),
      ),
      /**/
    );
  }
}
