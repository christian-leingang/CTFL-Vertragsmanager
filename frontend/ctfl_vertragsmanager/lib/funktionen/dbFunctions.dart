import 'dart:convert';
import 'dart:html';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:http/http.dart' as http;

import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> createUser(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Uri url = Uri.parse('http://10.0.2.2:8080/api/users');
  Map<String, String> body = {
    "email": profil.email,
    "password": profil.password,
    "image": profil.profilbild,
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response.statusCode == 200;
}

createSession(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  Uri url = Uri.parse('http://10.0.2.2:8080/api/sessions');
  Map<String, String> body = {
    "email": profil.email,
    "password": profil.password,
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  //Create UserProfile with Tokens
  if (response.body.startsWith("Invalid")) return false;

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Profile newUser = Profile(
    email: profil.email,
    password: profil.password,
    accessToken: responseMap["accessToken"],
    refreshToken: responseMap["refreshToken"],
    profilbild: responseMap["profilbild"],
  );
  Map<String, dynamic> userMap = {
    'email': newUser.email,
    'password': newUser.password,
    'accessToken': newUser.accessToken,
    'refreshToken': newUser.refreshToken,
    'profilbild': newUser.profilbild,
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);

  return response.statusCode == 200;
}

//todo: Absprache gibt uns alle aktuell angemeldeten User zurück, brauchen wir nicht, oder?
getSession() async {}

deleteSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Profile user = await getProfilFromPrefs();
  Uri url = Uri.parse('http://10.0.2.2:8080/api/sessions');
  http.Response response = await http.delete(
    url,
    headers: {"Content-Type": "application/json", "x-refresh": user.refreshToken},
  );
  if (response.body.startsWith("Invalid")) return false;
  return response.statusCode == 200;
}

createVertrag(Vertrag newVertrag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  Uri url = Uri.parse('http://10.0.2.2:8080/api/products');
  Map<String, String> body = {
    "name": newVertrag.name,
    "label": newVertrag.getLabelName(),
    "description": newVertrag.beschreibung,
    "intervall": newVertrag.intervall,
    "beitrag": newVertrag.getBeitragNumber(),
    "vertragsBeginn": newVertrag.getVertragsBeginn(),
    "vertragsEnde": newVertrag.getVertragsEnde(),
    "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    "erstZahlung": newVertrag.getErstzahlung(),
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  //Create UserProfile with Tokens
  if (response.body.startsWith("Invalid")) return false;

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Vertrag newUser = Vertrag(
    name: responseMap["name"],
    label: responseMap["label"],
    beschreibung: responseMap["description"],
    intervall: responseMap["intervall"],
    beitrag: responseMap["beitrag"],
    vertragsBeginn: responseMap["vertragsBeginn"],
    vertragsEnde: responseMap["vertragsEnde"],
    kuendigungsfrist: responseMap["kuendigungsfrist"],
    erstZahlung: responseMap["erstZahlung"],
  );
  Map<String, dynamic> userMap = {
    "name": newVertrag.name,
    "label": newVertrag.getLabelName(),
    "beschreibung": newVertrag.beschreibung,
    "intervall": newVertrag.intervall,
    "beitrag": newVertrag.getBeitragNumber(),
    "vertragsBeginn": newVertrag.getVertragsBeginn(),
    "vertragsEnde": newVertrag.getVertragsEnde(),
    "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    "erstZahlung": newVertrag.getErstzahlung(),
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);

  return response.statusCode == 200;
}

getVertrag() async {}

updateVertrag() async {}

deleteVertrag() async {}

getAllVertraege() async {}

Future<Profile> getProfilFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final rawJson = prefs.getString('profile');
  Map<String, dynamic> map = jsonDecode(rawJson!);
  final user = Profile(
    email: map['email'],
    password: map['password'],
    accessToken: ['accessToken'],
    refreshToken: ['refreshToken'],
    profilbild: ['profilbild'],
  );
  return user;
}
