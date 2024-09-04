import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final List<String> entries = <String>["Abc", "cdf", "lfg"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Focused time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 50, // Specify a fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.all(8),
                color: Colors.red,
                child: Center(child: Text(entries[index])),
              );
            },
          ),
        ),
      ],
    );
  }
}
