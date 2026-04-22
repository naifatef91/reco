import 'dart:ui';

class AppSettings {
  const AppSettings({
    required this.locale,
    required this.biometricEnabled,
    required this.initialized,
  });

  final Locale locale;
  final bool biometricEnabled;
  final bool initialized;

  AppSettings copyWith({
    Locale? locale,
    bool? biometricEnabled,
    bool? initialized,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      initialized: initialized ?? this.initialized,
    );
  }

  static const initial = AppSettings(
    locale: Locale('en'),
    biometricEnabled: false,
    initialized: false,
  );
}
