import 'package:diet_track/screens/account/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  UserAccountPageState createState() => UserAccountPageState();
}

class UserAccountPageState extends State<UserAccountPage> {
  // final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Settings',
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.5,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 10),
                        child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage:
                                AssetImage('assets/images/user.jpeg')),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('user@email.com',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(Icons.question_mark_rounded),
                  title: const Text("Help"),
                  onTap: () {},
                ),
                const ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text(
                    "Theme",
                  ),
                  // trailing: Switch(
                  //   activeColor: kPrimaryColor,
                  //   value: _themeController.isDarkMode.value,
                  //   onChanged: (value) => _themeController.toggleTheme(),
                  // ),
                ),
                ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Sign out"),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAndToNamed(LoginScreen.routeName);
                    }),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Privacy",
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: Text(
                    "Terms of Service",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Diet Track",
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
