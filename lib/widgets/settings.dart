import 'package:flutter/material.dart';
import 'package:timer_app/widgets/focused_time.dart';
import 'package:timer_app/widgets/tags_section.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [FocusedTime(), SizedBox(height: 0), TagsSection()],
      ),
    );
  }
}
