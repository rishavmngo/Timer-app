import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/pages/home_page.dart';
import 'package:timer_app/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  //@override
  //Widget build(BuildContext context) {
  //  return Scaffold(
  //    body: StreamBuilder(
  //        stream: FirebaseAuth.instance.authStateChanges(),
  //        builder: (context, snapShot) {
  //          print(snapShot.hasData);
  //          print("after change");
  //          if (snapShot.hasData) {
  //            print("excuted homepage");
  //
  //            return HomePage();
  //          } else {
  //            return const LoginPage();
  //          }
  //        }),
  //  );
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FirebaseAuth.instance.currentUser != null
            ? HomePage()
            : LoginPage());
  }
}
