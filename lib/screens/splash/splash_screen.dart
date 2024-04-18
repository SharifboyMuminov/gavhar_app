import 'package:flutter/material.dart';
import 'package:gavhar_app/utils/size_app.dart';
import 'package:lottie/lottie.dart';
import 'package:gavhar_app/screens/tab_box.dart';

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
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const TabScreen();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
