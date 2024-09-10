import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/pages/settings.dart';
import 'package:timer_app/pages/stats.dart';

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
    ButtonStyle active = TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
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
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  //color: Colors.black.withAlpha(100),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: TextButton(
                          style: currentPage == 0 ? active : null,
                          onPressed: () {
                            _togglePage(0);
                          },
                          child: Text("Stats",
                              style: TextStyle(
                                fontSize: 15,
                                color: currentPage == 0
                                    ? Colors.white
                                    : Colors.black87,
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: TextButton(
                          style: currentPage == 1 ? active : null,
                          onPressed: () {
                            //pageController.jumpToPage(1);
                            _togglePage(1);
                          },
                          child: Text("Settings",
                              style: TextStyle(
                                fontSize: 15,
                                color: currentPage == 1
                                    ? Colors.white
                                    : Colors.black87,
                              ))),
                    ),
                  ],
                ),
              ),
              Spacer()
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    //setState(() {
                    //  _currentIndex = index;
                    //});
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    Stats(),
                    Settings(),
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
