import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/pages/mainPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

const users = const {
  'abc@gmail.com': '12345',
  'cde@gmail.com': 'hunter',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
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

  Future<String?> _signupUser(SignupData data) {
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
