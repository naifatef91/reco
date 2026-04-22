import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:support_call_recorder/application/app_settings.dart';

class AppSettingsStore {
  static const _languageKey = 'language_code';
  static const _biometricEnabledKey = 'biometric_enabled';

  Future<AppSettings> read() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    final biometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;

    return AppSettings(
      locale: Locale(languageCode),
      biometricEnabled: biometricEnabled,
      initialized: true,
    );
  }

  Future<void> saveLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  Future<void> saveBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }
}
