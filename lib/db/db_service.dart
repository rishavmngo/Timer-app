import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timer_app/models/session.dart';
import 'package:timer_app/utils/tag_color.dart';

class DbService {
  Future<void> addTag(String name, Color color) async {
    final client = Supabase.instance.client;
    SupabaseQueryBuilder tags = client.from("Tags");
    final String id = client.auth.currentUser?.id ?? "nothing";

    try {
      await tags.insert([
        {"owner_id": id, "name": name, "color": color.value.toRadixString(16)}
      ]);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteTag(String tagId) async {
    final client = Supabase.instance.client;
    SupabaseQueryBuilder tagsTable = client.from("Tags");
    final String id = client.auth.currentUser?.id ?? "nothing";

    try {
      await tagsTable.delete().eq("id", int.parse(tagId)).eq("owner_id", id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> updateTag(Tag tag) async {
    final client = Supabase.instance.client;
    SupabaseQueryBuilder tagsTable = client.from("Tags");
    final String id = client.auth.currentUser?.id ?? "nothing";

    try {
      await tagsTable
          .update({
            "name": tag.name,
            "color": tag.color.value.toRadixString(16),
          })
          .eq("id", int.parse(tag.id))
          .eq("owner_id", id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> saveSession(TimerSession session) async {
    //CollectionReference sessions =
    //    FirebaseFirestore.instance.collection("sessions");
    //
    //try {
    //  await sessions.add({
    //    "uid": session.uid,
    //    "duration": session.duration,
    //    "label": session.label,
    //    "isHealthy": session.isHealthy,
    //    "timestamp": session.timestamp
    //  });
    //} catch (e) {
    //  log(e.toString());
    //}
  }

  Future<List<Tag>> getAllTags() async {
    final client = Supabase.instance.client;
    SupabaseQueryBuilder tagsTable = client.from("Tags");
    final String id = client.auth.currentUser?.id ?? "nothing";

    try {
      var tags = await tagsTable.select("*").eq('owner_id', id);

      return tags.map((item) {
        return Tag(
            id: item['id'].toString(),
            name: item['name'],
            color: Color(int.parse(item['color'], radix: 16)));
      }).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
