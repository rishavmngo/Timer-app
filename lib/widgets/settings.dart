import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final List<String> entries = <String>["Abc", "cdf", "lfg"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Container(
        color: Colors.lime,
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start
            children: [
              Container(
                color: Colors.blue,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text("Focused time"),
                    ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          return Container(
                              color: Colors.red, child: Text(entries[index]));
                        })
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
