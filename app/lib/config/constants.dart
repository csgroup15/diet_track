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
