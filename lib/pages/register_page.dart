import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timer_app/auth/auth_service.dart';
import 'package:timer_app/pages/home_page.dart';
import 'package:timer_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void register(BuildContext context) async {
    final authService = AuthService();
    try {
      final AuthResponse res = await authService.signUpWithEmailPassword(
          _emailController.text, _passwordController.text);
      if (res.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Verification email sent. Please check your inbox.')),
        );
        // Optionally navigate to a "Check your email" page
      }
      //await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()));
    } catch (e) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(e.toString()),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor, // Color of you choice
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(height: 100),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70),
                      ),
                      Text(
                        "Please register to continue",
                        style: TextStyle(fontSize: 18, color: Colors.white38),
                      )
                    ],
                  ),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.white70,
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Email"),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: !isPasswordVisible,
                    style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(!isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        suffixIconColor: Colors.white70,
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.white70,
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Password"),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !isConfirmPasswordVisible,
                    style: const TextStyle(color: Colors.white70),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(!isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        suffixIconColor: Colors.white70,
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: Colors.white70,
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Confirm Password"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _passwordController.text ==
                                  _confirmPasswordController.text) {
                            register(context);
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25)),
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a member?",
                        style: TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
