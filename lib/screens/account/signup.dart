import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../../services/firebase/auth_service.dart';
import '../../services/hive/write_hive.dart';
import '../../utils/validator.dart';
import '../landing_page.dart';
import '../widgets/primary_button.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final TextEditingController _givenNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isTermsAgreed = false;
  var rememberValue = false;
  final _formKey = GlobalKey<FormState>();

  //password field obscureText  handler
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.07,
                left: 23,
                right: 23,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create your',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w300),
                    ),
                    const Text(
                      'Account',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 40.0),
                    const Text(
                      'Given Name *',
                      style: TextStyle(
                          color: kSignUpFormHintTextColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _givenNameController,
                      validator: (value) => value!.isNotEmpty
                          ? null
                          : 'Please enter your given name',
                      style: const TextStyle(color: kSignUpFormHintTextColor),
                      decoration: InputDecoration(
                        labelText: 'e.g Joseph',
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: kSignUpFormHintTextColor),
                        prefixIcon: const Icon(Icons.person_outlined,
                            color: kSignUpFormIconsColor),
                        contentPadding:
                            const EdgeInsets.all(kSignUpFormContentPadding),
                        fillColor: kSignUpFormFillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const Text(
                      'Other Names *',
                      style: TextStyle(
                          color: kSignUpFormHintTextColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _otherNamesController,
                      validator: (value) => value!.isNotEmpty
                          ? null
                          : 'Please enter all other names',
                      style: const TextStyle(color: kSignUpFormHintTextColor),
                      decoration: InputDecoration(
                        labelText: 'e.g Kabanda',
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: kSignUpFormHintTextColor),
                        prefixIcon: const Icon(Icons.person_outlined,
                            color: kSignUpFormIconsColor),
                        contentPadding:
                            const EdgeInsets.all(kSignUpFormContentPadding),
                        fillColor: kSignUpFormFillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Email *',
                      style: TextStyle(
                          color: kSignUpFormHintTextColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: kSignUpFormHintTextColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else {
                          String email = _emailController.text.trim();
                          bool result = UserInfoValidator.validateEmail(email);
                          if (result) {
                            // create account event
                            return null;
                          } else {
                            return "Please enter a valid email";
                          }
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: kSignUpFormHintTextColor),
                        prefixIcon: const Icon(Icons.email,
                            color: kSignUpFormIconsColor),
                        fillColor: kSignUpFormFillColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding:
                            const EdgeInsets.all(kSignUpFormContentPadding),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Password *',
                      style: TextStyle(
                          color: kSignUpFormHintTextColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: kSignUpFormHintTextColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the password';
                        } else if (value.length <= 8) {
                          return 'Password must be greater than 8 characters';
                        } else {
                          bool result =
                              UserInfoValidator.validatePassword(value);
                          if (result) {
                            // create account event
                            return null;
                          } else {
                            return " Password should contain a capital letter, \nsmall letter, number & a special character";
                          }
                        }
                      },
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: kSignUpFormHintTextColor),
                        fillColor: kSignUpFormFillColor,
                        contentPadding:
                            const EdgeInsets.all(kSignUpFormContentPadding),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(Icons.lock,
                            color: kSignUpFormIconsColor),
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibility,
                          icon: _isHidden
                              ? const Icon(Icons.visibility,
                                  color: kSignUpFormIconsColor)
                              : const Icon(Icons.visibility_off,
                                  color: kSignUpFormIconsColor),
                        ),
                        labelText: '***************',
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Confirm passsword *',
                      style: TextStyle(
                          color: kSignUpFormHintTextColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _confirmPassword,
                      style: const TextStyle(color: kSignUpFormHintTextColor),
                      validator: (value) {
                        if (_passwordController.text != _confirmPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: kSignUpFormHintTextColor),
                        fillColor: kSignUpFormFillColor,
                        contentPadding:
                            const EdgeInsets.all(kSignUpFormContentPadding),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        prefixIcon: const Icon(Icons.lock,
                            color: kSignUpFormIconsColor),
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibility,
                          icon: _isHidden
                              ? const Icon(Icons.visibility,
                                  color: kSignUpFormIconsColor)
                              : const Icon(Icons.visibility_off,
                                  color: kSignUpFormIconsColor),
                        ),
                        labelText: '***************',
                      ),
                    ),
                    const SizedBox(height: 23),
                    PrimaryButton(
                        text: 'Register',
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final message = await AuthService().registration(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              if (message!.contains('Success')) {
                                final FirebaseAuth auth = FirebaseAuth.instance;

                                final User? currentUser = auth.currentUser;
                                final uid = currentUser?.uid;
                                UserModel newUser = UserModel(
                                  userID: uid!,
                                  givenName: _givenNameController.text.trim(),
                                  otherNames: _otherNamesController.text.trim(),
                                  email: _emailController.text.trim(),
                                );

                                newUser.addUserData(newUser);
                                await saveUserModelToHive(currUserID);
                                await saveFoodScanResultsToHive(currUserID);

                                if (!mounted) return;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LandingPage()));
                              } else {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(message),
                                  duration: const Duration(seconds: 5),
                                ));
                              }
                            } catch (e, s) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                duration: const Duration(seconds: 5),
                              ));
                              await FirebaseCrashlytics.instance.recordError(
                                e,
                                s,
                              );
                            }
                          }
                        }),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            'Have an account? Go to Login',
                            style: TextStyle(fontSize: 17, color: kWhiteColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
