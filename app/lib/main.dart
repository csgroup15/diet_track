import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/constants.dart';
import 'screens/account/login.dart';
import 'screens/data_load_screen.dart';
import 'screens/landing_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/firebase/auth_service.dart';
import 'services/hive/food_model_hive.dart';
import 'services/hive/nutrient_model_hive.dart';
import 'services/hive/result_model_hive.dart';
import 'services/hive/user_model_hive.dart';
import 'services/hive/write_hive.dart';

final currUserID = FirebaseAuth.instance.currentUser!.uid;

//TODO Concatenate images sent from api and come in color
Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    bool isLoggedIn = await isUserLoggedIn();

    await Hive.initFlutter();
    Hive.registerAdapter(UserModelHiveAdapter());
    Hive.registerAdapter(FoodModelHiveAdapter());
    Hive.registerAdapter(FoodNutrientHiveAdapter());
    await Hive.openBox('user_info');
    Hive.registerAdapter(ResultModelHiveAdapter());
    await Hive.openBox('results');

    if (isLoggedIn) {
      await saveUserModelToHive(currUserID);
      await saveFoodScanResultsToHive(currUserID);
    }
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialColor mPrimarySwatch = createMaterialColor(kPrimaryColor);

    return AdaptiveTheme(
      light: ThemeData(
        fontFamily: 'SF-Pro-Rounded',
        brightness: Brightness.light,
        primarySwatch: mPrimarySwatch,
        primaryColor: kPrimaryColor,
      ),
      dark: ThemeData(
        fontFamily: 'SF-Pro-Rounded',
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        primarySwatch: mPrimarySwatch,
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: 'Diet Track',
        theme: theme,
        darkTheme: darkTheme,
        home: checkAuth(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget checkAuth() {
    Widget widget;
    widget = FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString(),
              style: const TextStyle(fontSize: 10));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return snapshot.hasData ? checkModels() : const LoginScreen();
            },
          );
        } else {
          return const Text('');
        }
      },
    );
    return widget;
  }

  Widget checkModels() {
    Widget widget;
    widget = userDataBox.isNotEmpty
        ? const LandingPage()
        : const DataLoadingScreen();
    return widget;
  }
}
