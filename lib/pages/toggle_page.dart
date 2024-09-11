import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/pages/day.dart';
import 'package:timer_app/pages/month.dart';
import 'package:timer_app/pages/settings.dart';
import 'package:timer_app/pages/week.dart';
import 'package:timer_app/pages/year.dart';
import 'package:timer_app/widgets/stats_page_button.dart';

class TogglePage extends StatefulWidget {
  final int page;
  const TogglePage({super.key, required this.page});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool isStats = false;
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    currentPage = widget.page;
    pageController = PageController(initialPage: widget.page);
  }

  void _togglePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
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
            actions: [Spacer(), Spacer()],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatsBtn(currentPage: currentPage, togglePage: _togglePage),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    Day(),
                    Week(),
                    Month(),
                    Year(),
                  ],
                ),
              ),
              //ElevatedButton(
              //  onPressed: () => _togglePage(0),
              //  child: Text('Stats'),
              //),
              //ElevatedButton(
              //  onPressed: () => _togglePage(1),
              //  child: Text('Settings'),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
