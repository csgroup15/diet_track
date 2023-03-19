import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../services/firebase/auth_service.dart';
import '../widgets/primary_button.dart';
import 'login.dart';
import 'signup.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/register.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Stack(
              children: [
                Positioned(
                  bottom: 150,
                  left: 0,
                  right: 0,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reset password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(
                                color: kSignUpFormHintTextColor),
                            validator: (value) => value!.isNotEmpty
                                ? null
                                : 'Please enter the Email',
                            decoration: InputDecoration(
                              labelText: 'Enter your email Address',
                              hintStyle: const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(
                                  color: kSignUpFormHintTextColor),
                              prefixIcon: const Icon(Icons.email,
                                  color: kSignUpFormIconsColor),
                              fillColor: kSignUpFormFillColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: const EdgeInsets.all(
                                  kSignUpFormContentPadding),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          PrimaryButton(
                              text: 'Reset',
                              press: () async {
                                if (_formKey.currentState!.validate()) {
                                  final message =
                                      await AuthService().resetPassword(
                                    email: _emailController.text,
                                  );
                                  if (message!.contains('Success')) {
                                    resetMessage();
                                  }
                                }
                              }),
                          const SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          //backgroundColor: kScaffoldColor,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 150.0,
            width: 50.0,
            decoration: BoxDecoration(
                color: kWhiteSmokeColor,
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Check your email for the link to reset your password\nthen login with the new password',
                        style: TextStyle(
                          color: kBlackColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
}
