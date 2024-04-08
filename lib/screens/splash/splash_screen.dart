import 'package:flutter/material.dart';
import 'package:gavhar_app/screens/home/home_screen.dart';
import 'package:gavhar_app/screens/widgets/my_navigator.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nextHome();
    super.initState();
  }

  nextHome() async {
    Future.delayed(const Duration(seconds: 3), () {
      myNavigator(context, screen: const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 1,
          child: Lottie.asset(
            "assets/lottie/splash.json",
          ),
        ),
      ),
    );
  }
}
