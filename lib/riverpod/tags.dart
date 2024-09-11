import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/utils/local_storage.dart';

final currentTagProvider =
    StateProvider<int>((ref) => ref.read(settingsProvider).defaultTag);
