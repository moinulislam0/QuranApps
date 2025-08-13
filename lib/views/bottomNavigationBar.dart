import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:quran/containts/Containts.dart';
import 'package:quran/controller/bottombarController.dart';
import 'package:quran/views/hadithPage.dart';
import 'package:quran/views/sura_list_pages.dart';
import 'package:quran/views/weatherPage.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  List<Widget> screen = [SuraListPages(), Hadithpage(), Weatherpage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomBarController>(
        builder: (controller) {
          return screen[controller.SelectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomBarController>(
        builder: (controller) {
          return BottomNavigationBar(
            backgroundColor: Containts.secondaryColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,

            currentIndex: controller.SelectedIndex,
            onTap: (value) {
              controller.changeIndex(value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_sharp),
                label: "Hadith",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: "Weather",
              ),
            ],
          );
        },
      ),
    );
  }
}
