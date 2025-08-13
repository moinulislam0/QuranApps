import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quran/views/splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Quran App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
