import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

import 'ChooseOption.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: const [
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/Veka-Green.png"),
          ),
          CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/Veka-Red.png"),
          )
          // Image.asset("assets/Veka-Green.png"),
          // Image.asset("assets/Veka-Red.png")
        ],
      ),
      nextScreen: const ChooseOption(),

      duration: 3500,
      splashIconSize: 500,
      //splashTransition: SplashTransition.,
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
