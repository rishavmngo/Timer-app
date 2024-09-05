import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagNotifier extends StateNotifier<int> {
  TagNotifier() : super(0); // initial value

  void setItemId(int itemId) => state = itemId;
}

final tagProvider =
    StateNotifierProvider<TagNotifier, int>((ref) => TagNotifier());
