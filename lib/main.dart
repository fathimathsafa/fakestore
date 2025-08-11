import 'package:flutter/material.dart';
import 'package:fake_store/core/constants/color_constants.dart';
import 'package:fake_store/presentation/splash_screen/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      home: const SplashScreen(),
    );
  }
}
