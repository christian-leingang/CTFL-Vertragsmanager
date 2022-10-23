import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:ctfl_vertragsmanager/pages/main_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    Profile existingUser = Profile(email: data.name, password: hashPW(data.password));
    bool sessionCreated = await createSession(existingUser);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (sessionCreated) {
      await getAllLabels();
      await getAllVertraege();

      prefs.setBool('isLoggedIn', true);
    } else {
      return 'Benutzer konnte nicht registriert werden.';
    }
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Profile newUser = Profile(email: data.name!, password: hashPW(data.password!));
    bool userCreated = await createUser(newUser);
    if (userCreated) {
      await createSession(newUser);
      await getAllLabels();

      prefs.setBool('isLoggedIn', true);
    } else {
      return 'Benutzer konnte nicht registriert werden.';
    }

    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String email) async {
    bool forgotPW = await forgetPassword(email);

    return Future.delayed(loginTime).then((_) {
      if (!forgotPW) {
        return 'Benutzer existiert nicht.';
      }
      // ignore: dead_code
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // const inputBorder = BorderRadius.vertical(
    //   bottom: Radius.circular(10.0),
    //   top: Radius.circular(20.0),
    // );

    return FlutterLogin(
      logo: const AssetImage(
        'assets/logo3.png',
      ),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPages(),
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
        accentColor: Colors.grey,
        textFieldStyle: const TextStyle(),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.15),
        ),
      ),
    );
  }
}
