import 'dart:ui';

class AppSettings {
  const AppSettings({
    required this.locale,
    required this.biometricEnabled,
    required this.excludedNumbers,
    required this.legalConsentAccepted,
    required this.initialized,
  });

  final Locale locale;
  final bool biometricEnabled;
  final List<String> excludedNumbers;
  final bool legalConsentAccepted;
  final bool initialized;

  AppSettings copyWith({
    Locale? locale,
    bool? biometricEnabled,
    List<String>? excludedNumbers,
    bool? legalConsentAccepted,
    bool? initialized,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      excludedNumbers: excludedNumbers ?? this.excludedNumbers,
      legalConsentAccepted: legalConsentAccepted ?? this.legalConsentAccepted,
      initialized: initialized ?? this.initialized,
    );
  }

  static const initial = AppSettings(
    locale: Locale('en'),
    biometricEnabled: false,
    excludedNumbers: <String>[],
    legalConsentAccepted: false,
    initialized: false,
  );
}
