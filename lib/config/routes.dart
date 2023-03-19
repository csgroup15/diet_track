import 'package:get/get.dart';
import '../screens/account/login.dart';
import '../screens/home/home_screen.dart';
import '../screens/landing_page.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const LandingPage(),
          name: LandingPage.routeName,
        ),
        GetPage(
          page: () => const HomeScreen(),
          name: HomeScreen.routeName,
        ),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
      ];
}
