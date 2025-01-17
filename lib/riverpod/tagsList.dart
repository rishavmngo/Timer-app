import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/db/db_service.dart';
import 'package:timer_app/utils/tag_color.dart';

class TagsListNotifier extends StateNotifier<AsyncValue<List<Tag>>> {
  TagsListNotifier() : super(const AsyncValue.loading()) {
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    try {
      final db = DbService();
      state = const AsyncValue.loading();

      var data = await db.getAllTags();
      //for (var d in data) {
      //  log(d.toString());
      //}

      state = AsyncValue.data(
          [...data, Tag(color: Colors.grey, name: "unset", id: "0")]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refreshTags() async {
    print("refreshTags");
    await _fetchTags();
  }
}

// Create a provider using the TagsNotifier
final tagsListProvider =
    StateNotifierProvider<TagsListNotifier, AsyncValue<List<Tag>>>((ref) {
  return TagsListNotifier();
});
