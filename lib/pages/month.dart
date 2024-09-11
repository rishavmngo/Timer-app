import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Month extends StatefulWidget {
  const Month({super.key});

  @override
  State<Month> createState() => _MonthState();
}

class _MonthState extends State<Month> {
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
            "Month",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
