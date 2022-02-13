import 'package:flutter/material.dart';
import 'package:nakshatra/constants.dart';
import 'package:nakshatra/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: SecondaryColor,
      splashIconSize: 150,
      splash: "assets/alveoliicon.png",
      nextScreen: LogIn(),
      splashTransition: SplashTransition.fadeTransition,
      curve: Curves.easeInExpo,
      animationDuration: Duration(seconds: 2),
    );
  }
}
