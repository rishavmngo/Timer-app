import 'package:flutter/material.dart';

class Tag {
  final Color color;
  final String name;
  final int id;

  Tag({required this.color, required this.name, required this.id});

  @override
  String toString() {
    return "$id $name ${color.value.toRadixString(16)}";
  }
}
