import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../services/firebase/auth_service.dart';
import '../landing_page.dart';
import '../splash_screen.dart';
import '../widgets/primary_button.dart';
import 'reset_password.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    CustomSplashScreen.initialization();
  }

  //password field obscureText  Handler
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login.jpeg',
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
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Back',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Log into your account',
                            style: TextStyle(
                                color: Color.fromARGB(228, 221, 216, 216),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.black),
                            validator: (value) => value!.isNotEmpty
                                ? null
                                : 'Please enter the Email',
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintStyle: const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color.fromARGB(193, 7, 6, 6),
                              ),
                              contentPadding: const EdgeInsets.all(21),
                              fillColor:
                                  const Color.fromARGB(104, 245, 245, 245),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          TextFormField(
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.black),
                            validator: (value) => value!.isNotEmpty
                                ? null
                                : 'Please enter the password',
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black),
                              labelStyle: const TextStyle(color: Colors.white),
                              contentPadding: const EdgeInsets.all(20),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor:
                                  const Color.fromARGB(104, 245, 245, 245),
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color.fromARGB(193, 7, 6, 6),
                              ),
                              suffixIcon: IconButton(
                                color: const Color.fromARGB(193, 7, 6, 6),
                                onPressed: _toggleVisibility,
                                icon: _isHidden
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              // hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(104, 245, 245, 245),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      fontSize: 17, color: kWhiteColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          PrimaryButton(
                              text: 'Sign In',
                              press: () async {
                                if (_formKey.currentState!.validate()) {
                                  final message = await AuthService().login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                  if (message!.contains('Success')) {
                                    if (!mounted) return;
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LandingPage(),
                                      ),
                                    );
                                  } else {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(message),
                                      duration: const Duration(seconds: 5),
                                    ));
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
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'No Account? Register now for free!',
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
}
