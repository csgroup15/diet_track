import 'package:get/get.dart';

import '../config/theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
        isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
