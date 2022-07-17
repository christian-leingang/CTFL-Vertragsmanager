import 'dart:io';
import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:ctfl_vertragsmanager/funktionen/profil_funktionen.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  Profile user = Profile(email: "", password: "");
  final File? profilePicture;

  ProfilPage({Key? key, this.profilePicture}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  getUserInformation() async {
    Profile user = await getProfilFromPrefs();
    setState(() {
      widget.user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Image(image: AssetImage('assets/logo.jpg')),
        title: const Text(
          "Profil",
        ),
      ),
      body: Center(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Column(
              children: [
                const Text("E-Mail:"),
                Text(
                  widget.user.email,
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.password),
                  subtitle: const Text("Möchten Sie Ihr Passwort ändern?"),
                  title: const Text("Passwort ändern"),
                  onTap: () {
                    createAlertDialogChangePassword(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.login_outlined),
                  subtitle: const Text("Möchten Sie sich abmelden?"),
                  title: const Text("Abmelden"),
                  onTap: () {
                    logout(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  subtitle: const Text("Möchten Sie Ihr Konto unwiderruflich löschen?"),
                  title: const Text("Konto löschen"),
                  onTap: () {
                    createAlertDialogDeleteProfile(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
