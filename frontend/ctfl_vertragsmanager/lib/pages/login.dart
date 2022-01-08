import 'dart:convert';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:ctfl_vertragsmanager/pages/mainPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const users = const {
  'abc@gmail.com': '12345',
  'cde@gmail.com': 'hunter',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Profile newUser = Profile(email: data.name, password: data.password);
    Map<String, dynamic> map = {'email': newUser.email, 'password': newUser.password};
    String rawJason = jsonEncode(map);

    prefs.setString('profile', rawJason);

    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Der Benutzer existiert nicht.';
      }
      if (users[data.name] != data.password) {
        return 'Das Passwort ist falsch.';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // File defaultPic =
    //     await ImageUtils.imageToFile(imageName: "default-profile-picture", ext: "png");
    var url = Uri.parse('http://10.0.2.2:8080/api/users');
    var body = {
      "email": data.name,
      "password": data.password,
      "passwordConfirmation": data.password,
      "name": data.name
    };
    var body_json = jsonEncode(body);
    var response = await http.post(
      url,
      body: body_json,
      headers: {"Content-Type": "application/json"},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) print("User created in");
    Profile newUser = Profile(email: data.name, password: data.password);

    Map<String, dynamic> map = {
      'email': newUser.email,
      'password': newUser.password,
      //'profilbild': newUser.profilbild
    };
    String rawJason = jsonEncode(map);

    prefs.setString('profile', rawJason);

    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Benutzer existiert nicht.';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
        logo: AssetImage(
          'assets/logo3.png',
        ),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainPages(),
          ));
        },
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          userHint: 'Email-Adresse',
          passwordHint: 'Passwort',
          confirmPasswordHint: 'Bestätigen',
          loginButton: 'Anmelden',
          signupButton: 'Registieren',
          forgotPasswordButton: 'Passwort vergessen?',
          recoverPasswordButton: 'Passwort bestätigen',
          goBackButton: 'zurück',
          confirmPasswordError: 'Keinen Nutzer gefunden',
          recoverPasswordDescription:
              'Geben sie ihre Email-Adresse an. Sie erhalten eine Mail mit allen weiteren Informationen zur Passwortrücksetzung.',
          recoverPasswordSuccess: 'Passwort erfolgreich zurückgesetzt',
          recoverPasswordIntro: "Passwort zurücksetzen:",
        ),
        theme: LoginTheme(
          textFieldStyle: TextStyle(),
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
          ),
        ));
  }
}
