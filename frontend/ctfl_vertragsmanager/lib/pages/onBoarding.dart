import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/pages/mainPages.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.popAndPushNamed(context, '/login');
    //Navigator.popAndPushNamed(context, '/main');
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/logo3.png'),
          ),
        )),
      ),

      pages: [
        PageViewModel(
          title: "Überall verfügbar",
          body:
              "Nutze den CTFL-Vertragsmanager bequem am Handy - egal ob iOS oder Android - oder über den Browser deiner Wahl.",
          image: Image.asset('assets/webdevices.png', height: 175.0),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Benachrichtigungen",
          body:
              "Erhalte zu den wichtigen Vertragszeitpunkten, wie die Kündigungsfrist oder das Vertragsende rechtzeitig eine Benachrichtigung.",
          image: Image.asset('assets/notifications.png', height: 175.0),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ordnerablage",
          body:
              "Schluss mit dem Suchen der Unterlagen! \n Lege deine Vertragsunterlagen an einem Ort sicher ab.",
          image: Image.asset('assets/notifications.png', height: 175.0),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xffD72324),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
