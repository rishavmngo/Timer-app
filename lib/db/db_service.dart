import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/models/session.dart';
import 'package:timer_app/utils/tag_color.dart';

class DbService {
  Future<void> addTag(String name, Color color) async {
    CollectionReference tags = FirebaseFirestore.instance.collection("tags");

    try {
      await tags.add({
        'name': name,
        'color': color.value.toRadixString(16),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteTag(String id) async {
    CollectionReference tags = FirebaseFirestore.instance.collection("tags");

    try {
      await tags.doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTag(Tag tag) async {
    CollectionReference tags = FirebaseFirestore.instance.collection("tags");

    try {
      await tags.doc(tag.id).update({
        "name": tag.name,
        "color": tag.color.value.toRadixString(16),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveSession(Session session) async {
    CollectionReference sessions =
        FirebaseFirestore.instance.collection("sessions");

    try {
      await sessions.add({
        "uid": session.uid,
        "duration": session.duration,
        "label": session.label,
        "isHealthy": session.isHealthy,
        "timestamp": session.timestamp
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Tag>> getAllTags() async {
    //FirebaseFirestore.instance.terminate();
    //FirebaseFirestore.instance.clearPersistence();
    CollectionReference tagsCollection =
        FirebaseFirestore.instance.collection("tags");

    try {
      var tags = await tagsCollection.snapshots().first;
      return tags.docs.toList().map((item) {
        Map<String, dynamic> d = item.data() as Map<String, dynamic>;
        //d['name'];
        return Tag(
            id: item.id,
            name: d['name'],
            color: Color(int.parse(d['color'], radix: 16)));
      }).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
