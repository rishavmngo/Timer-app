import 'package:flutter_riverpod/flutter_riverpod.dart';

final cachedTagIndex = StateProvider<int>((ref) => -1);
