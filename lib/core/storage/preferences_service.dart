import 'package:shared_preferences/shared_preferences.dart';

/// Wraps `shared_preferences` for lightweight, non-sensitive preferences.
///
/// The [SharedPreferences] instance is resolved once at startup and injected
/// via `preferencesServiceProvider` (see `core/providers/app_providers.dart`).
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'theme_mode';
  static const _onboardingSeenKey = 'onboarding_seen';

  // --- Generic API ---------------------------------------------------------
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  // --- Convenience getters/setters ----------------------------------------
  String? get themeMode => _prefs.getString(_themeModeKey);

  Future<bool> setThemeMode(String value) =>
      _prefs.setString(_themeModeKey, value);

  bool get onboardingSeen => _prefs.getBool(_onboardingSeenKey) ?? false;

  Future<bool> setOnboardingSeen({required bool value}) =>
      _prefs.setBool(_onboardingSeenKey, value);
}
