import 'package:diet_track/config/constants.dart';
import 'package:diet_track/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'account/settings.dart';
import 'results/results_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  static const String routeName = '/landingpage';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late List<Widget> pages;
  late Widget page1;
  late Widget page2;
  late Widget page3;
  late int currentIndex;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    page1 = const HomeScreen();
    page2 = const ResultsScreen();
    page3 = const UserAccountPage();
    pages = [page1, page2, page3];
    currentIndex = 0;
    currentPage = page1;
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          changeTab(index);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(
              AssetImage('assets/icons/home.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Results',
            icon: ImageIcon(
              AssetImage('assets/icons/recent.png'),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: ImageIcon(
              AssetImage('assets/icons/user.png'),
            ),
          ),
        ],
        elevation: 15,
        iconSize: 25,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
