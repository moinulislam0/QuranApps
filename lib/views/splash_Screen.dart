import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/views/sura_list_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
    ).then((value) => Get.off(() => SuraListPages()));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Containts.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/quran.png')),
          SizedBox(height: 10),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
