import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_app/models/settings.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs) : super(Settings(theme: 'light', duration: 5)) {
    _loadSettings();
  }

  void _loadSettings() {
    final theme = _prefs.getString('theme') ?? 'light';
    final duration = _prefs.getInt('duration') ?? 5;
    state = Settings(theme: theme, duration: duration);
  }

  Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
    state = state.copyWith(theme: theme);
  }

  Future<void> setDuration(int duration) async {
    await _prefs.setInt('duration', duration);
    state = state.copyWith(duration: duration);
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
