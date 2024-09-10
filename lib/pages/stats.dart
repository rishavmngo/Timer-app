import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
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
            "Stats",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
