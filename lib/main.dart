import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'controllers/theme_controller.dart';
import 'screens/account/login.dart';
import 'screens/landing_page.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

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
    Get.put(ThemeController());

    return GetMaterialApp(
      title: 'Diet Track',
      theme: AppTheme.lightTheme, // default theme
      //darkTheme: AppTheme.darkTheme,
      home: checkAuth(),
      getPages: AppRoutes.pages(),
      debugShowCheckedModeBanner: false,
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
              return snapshot.hasData
                  ? const LandingPage()
                  : const LoginScreen();
            },
          );
        } else {
          return const Text('Some error occured');
        }
      },
    );
    return widget;
  }
}
