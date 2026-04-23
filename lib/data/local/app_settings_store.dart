import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:support_call_recorder/application/app_settings.dart';

class AppSettingsStore {
  static const _languageKey = 'language_code';
  static const _biometricEnabledKey = 'biometric_enabled';
  static const _excludedNumbersKey = 'excluded_numbers';

  Future<AppSettings> read() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'en';
    final biometricEnabled = prefs.getBool(_biometricEnabledKey) ?? false;
    final excludedNumbers = prefs.getStringList(_excludedNumbersKey) ?? <String>[];

    return AppSettings(
      locale: Locale(languageCode),
      biometricEnabled: biometricEnabled,
      excludedNumbers: excludedNumbers,
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

  Future<void> saveExcludedNumbers(List<String> numbers) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_excludedNumbersKey, numbers);
  }
}
