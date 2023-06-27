import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key});

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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const BackButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'User Manual',
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.5,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '1. Installation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'To install the Diet Track application on your device, follow these steps:',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '1. Open Google Play Store on your device.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '2. Search for "Diet Track" in the search bar.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Locate the Diet Track application in the search results.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '4. Tap on the "Install" button.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '5. Wait for the installation to complete.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '6. Once installed, tap on the Diet Track icon to launch the application.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '2. Registration and Login',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'When you launch Diet Track for the first time, you will need to register an account or log in if you already have one. Follow these steps to register or log in:',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Registering a New Account',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '1. On the welcome screen, tap on the "Register" button.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '2. Enter the requested information.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Tap on the "Register" button to create your account.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '4. You may be required to verify your email address before proceeding.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Logging In',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '1. On the welcome screen, enter your remail address and password.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Tap on the "Sign In" button to access your account.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '3. Home Screen',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'After successfully logging in, you will be directed to the home screen\nThis screen provides an overview of your last scanned meal and \n a button to upload another image for scanning',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '4. Submitting a photo for scanning',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '1. From the home screen, tap on the “Choose Image” button.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '2. You will be presented with two options to choose a photo: camera or gallerly.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Select the appropriate option and follow the on-screen instructions',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '4. After the image is choosen, the application will send it for scanning, then retrieve and display the nutrient information for the food',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                const SizedBox(height: 16.0),
                const Text(
                  '5. Viewing past results',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '1. From the home screen, tap on card button on the bottom navigation bar.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '2. You will be presented with recently submitted photos.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Select a photo of your choice to view the results in detail',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '6. Account Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '1. From the home screen, tap on the user icon on the bottom navigation bar.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '2. You will be presented with settings screen.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '3. Select the needed option. From help, to signing out',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
