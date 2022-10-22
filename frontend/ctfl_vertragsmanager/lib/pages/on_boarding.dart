import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/scheduler.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> with TickerProviderStateMixin {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.popAndPushNamed(context, '/login');
    //Navigator.popAndPushNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      // descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? const Color.fromARGB(255, 45, 45, 45)
          : Colors.white,
      imagePadding: EdgeInsets.zero,

      imageFlex: 5,
      bodyFlex: 3,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? const Color.fromARGB(255, 45, 45, 45)
          : Colors.white,

      globalHeader: const Align(
        alignment: Alignment.center,
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(15.0),
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage('assets/logo3.png'),
          ),
        )),
      ),

      pages: [
        PageViewModel(
          title: "Überall verfügbar",
          body:
              "Nutze den CTFL-Vertragsmanager bequem am Handy - egal ob iOS oder Android - oder über den Browser deiner Wahl.",
          image: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 160.0),
              width: 250.0,
              height: 250.0,
              child: Lottie.asset(
                'assets/lottie/all_devices.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Benachrichtigungen",
          body:
              "Erhalte zu den wichtigen Vertragszeitpunkten, wie die Kündigungsfrist oder das Vertragsende rechtzeitig eine Benachrichtigung.",
          image: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 160.0),
              width: 250.0,
              height: 250.0,
              child: Lottie.asset(
                'assets/lottie/notification.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ordnerablage",
          body:
              "Schluss mit dem Suchen der Unterlagen! \n Lege deine Vertragsunterlagen an einem Ort sicher ab.",
          image: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 140.0),
              width: 400.0,
              height: 400.0,
              child: Lottie.asset(
                'assets/lottie/files_icon.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
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
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
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
      dotsContainerDecorator: ShapeDecoration(
        color: SchedulerBinding.instance.window.platformBrightness == Brightness.dark
            ? Colors.white30
            : Colors.black.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
