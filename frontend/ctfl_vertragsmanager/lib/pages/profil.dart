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
              margin: EdgeInsets.all(40),
              child: Icon(
                Icons.account_circle_outlined,
                size: 150,
              ),
            ),
            Column(
              children: [
                Text("Name:"),
                Text(
                  name,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text("E-Mail:"),
                Text(
                  email,
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Konto löschen"),
                style: TextButton.styleFrom(backgroundColor: Color(0xffD72324)),
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
        backgroundColor: Color(0xffD72324),
        child: const Icon(
          Icons.edit,
          size: 25,
        ),
      ),
      /**/
    );
  }
}
