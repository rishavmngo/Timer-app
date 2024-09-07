import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/auth/auth_service.dart';
import 'package:timer_app/pages/login_page.dart';
import 'package:timer_app/widgets/banner_text.dart';
import 'package:timer_app/widgets/button_primary.dart';
import 'package:timer_app/widgets/home_screen_tag.dart';
import 'package:timer_app/widgets/progress_bar.dart';
import 'package:timer_app/widgets/timer_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(context) async {
    final auth = AuthService();
    await auth.signOut();
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor, // Color of you choice
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                    onPressed: () => logout(context),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            body: const Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    BannerText(),
                    SizedBox(height: 80),
                    ProgressBar(),
                    SizedBox(height: 50),
                    TimerTag(),
                    SizedBox(height: 10),
                    TimerTime(),
                    SizedBox(height: 10),
                    ButtonPrm(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
