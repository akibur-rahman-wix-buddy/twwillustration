
import 'package:flutter/material.dart';
import 'assets_helper/app_image.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Image.asset(
          AppImages.fullSplash,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}