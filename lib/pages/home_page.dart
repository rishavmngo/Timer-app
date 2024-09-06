import 'package:flutter/material.dart';
import 'package:timer_app/widgets/banner_text.dart';
import 'package:timer_app/widgets/button_primary.dart';
import 'package:timer_app/widgets/home_screen_tag.dart';
import 'package:timer_app/widgets/progress_bar.dart';
import 'package:timer_app/widgets/timer_time.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
    );
  }
}
