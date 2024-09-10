import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_app/models/settings.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs)
      : super(Settings(theme: 'light', duration: 5, defaultTag: "")) {
    _loadSettings();
  }

  void _loadSettings() {
    final theme = _prefs.getString('theme') ?? 'light';
    final duration = _prefs.getInt('duration') ?? 5;
    final defaultTag = _prefs.getString('defaultTag') ?? "";
    state = Settings(theme: theme, duration: duration, defaultTag: defaultTag);
    _inspectPrefs();
  }

  //ignore: unused_element
  void _inspectPrefs() {
    final keys = _prefs.getKeys();
    Map<String, dynamic> prefsMap = {};

    for (String key in keys) {
      prefsMap[key] = _prefs.get(key);
    }
    print('Insepect: ');
    prefsMap.forEach((key, value) {
      print('$key: $value');
    });
  }

  Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
    state = state.copyWith(theme: theme);
  }

  Future<void> setDuration(int duration) async {
    await _prefs.setInt('duration', duration);
    state = state.copyWith(duration: duration);
  }

  Future<void> setDefaultTag(String defaultTag) async {
    await _prefs.setString('defaultTag', defaultTag);
    state = state.copyWith(defaultTag: defaultTag);
  }

  Future<void> refreshSettings(Settings newSettings) async {
    await _prefs.setString('theme', newSettings.theme);
    await _prefs.setInt('duration', newSettings.duration);

    state = newSettings;
  }
}

// Provider for settings
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});


// save(state.copywith(theme: "dark"))
