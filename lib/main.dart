import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:quran/controller/bottombarController.dart';
import 'package:quran/views/splash_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxBinding(),
      title: "Quran App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class GetxBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BottomBarController());
  }
}
