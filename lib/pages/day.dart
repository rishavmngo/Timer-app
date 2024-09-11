import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Day extends StatefulWidget {
  const Day({super.key});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor, // Your desired color
          statusBarIconBrightness: Brightness.light, // White icons
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor, // Color of you choice
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Container(
          //color: Colors.black,
          child: const Text(
            "Day",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
