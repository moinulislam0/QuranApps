import 'package:get/get.dart';

class BottomBarController extends GetxController{
  int _selectedIndex = 0;
  int get SelectedIndex => _selectedIndex;
  void changeIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
