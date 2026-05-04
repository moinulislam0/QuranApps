import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:quran/controller/bottombarController.dart';
import 'package:quran/views/splash_Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F1CF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC4B000),
          primary: const Color(0xFFC4B000),
          secondary: const Color(0xFFE3D55B),
          surface: const Color(0xFFFFFBE9),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFFC4B000),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        cardTheme: CardThemeData(
          color: Colors.white.withValues(alpha: 0.88),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2A2611),
          ),
          titleLarge: TextStyle(
            fontSize: 30,
            height: 1.9,
            color: Color(0xFF201C0A),
          ),
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2A2611),
          ),
          titleSmall: TextStyle(
            fontSize: 17,
            height: 1.6,
            color: Color(0xFF2F2A17),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF5F572F),
          ),
        ),
      ),
      home: const SplashScreen(),
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
