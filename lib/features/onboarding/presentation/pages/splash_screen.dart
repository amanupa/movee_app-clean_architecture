import 'package:flutter/material.dart';
import 'package:movee_app/core/constant/app_colors.dart';

import 'package:movee_app/features/get_Movies/presentation/pages/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: double.maxFinite,
        child: Image.asset("assets/splashScreenImage.jpg", fit: BoxFit.cover),
      ),
    );
  }
}
