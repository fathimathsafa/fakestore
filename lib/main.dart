import 'package:fake_store/presentation/login_screen/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fake_store/core/constants/color_constants.dart';
import 'package:fake_store/presentation/splash_screen/view/splash_screen.dart';
import 'package:fake_store/presentation/login_screen/view/login_screen.dart';
import 'package:fake_store/presentation/home_screen/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SnapCart',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorTheme.primaryColor,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Arial',
          ),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const SplashScreen()),
            GetPage(name: '/login', page: () => const LogInScreen()),
            GetPage(name: '/home', page: () => const HomeScreen()),
          ],
        );
      },
    );
  }
}
