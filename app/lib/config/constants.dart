import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const kPrimaryColor = Color(0xFF1b8304);
const kGreyIconColor = Color(0xF3F2F3F4);
const kWhiteSmokeColor = Color(0xFFFFFFFF);
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Colors.red;
const kSignUpFormFillColor = Color.fromARGB(104, 160, 114, 114);
const kSignUpFormIconsColor = Color.fromARGB(172, 247, 242, 242);
const kSignUpFormHintTextColor = Color.fromARGB(172, 247, 242, 242);
const kLightGreyContainer = Color(0xFFF5F5F5);
const kBottomSheetContainer = Color.fromARGB(255, 59, 173, 129);

const kDefaultPadding = 20.0;
const kSignUpFormContentPadding = 19.0;

final userDataBox = Hive.box('user_info');
final userResultsBox = Hive.box('results');

MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
