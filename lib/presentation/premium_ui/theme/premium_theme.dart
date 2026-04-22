import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';

@immutable
class PremiumColors {
  const PremiumColors._();

  static const Color offWhite = Color(0xFFF8FAFC);
  static const Color deepBlue = Color(0xFF1E3A8A);
  static const Color indigo = Color(0xFF4338CA);
  static const Color softPurple = Color(0xFFA78BFA);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color cardBorder = Color(0x66FFFFFF);
  static const Color darkSurface = Color(0xFF0B1220);
}

@immutable
class PremiumTheme {
  const PremiumTheme._();

  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[PremiumColors.deepBlue, PremiumColors.indigo],
  );

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PremiumColors.indigo,
        brightness: Brightness.light,
        surface: PremiumColors.offWhite,
      ),
      scaffoldBackgroundColor: PremiumColors.offWhite,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: PremiumColors.textPrimary,
        displayColor: PremiumColors.textPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white.withValues(alpha: PremiumOpacity.glassCardTheme),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PremiumRadius.lg),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: PremiumOpacity.inputFill),
        hintStyle: const TextStyle(color: PremiumColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumRadius.md),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: PremiumOpacity.inputBorder),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(PremiumRadius.md),
          borderSide: const BorderSide(color: PremiumColors.indigo, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PremiumRadius.lg),
          ),
        ),
      ),
    );
  }

  static List<BoxShadow> softShadow() {
    return const <BoxShadow>[
      BoxShadow(
        color: PremiumElevation.shadowColor,
        blurRadius: PremiumElevation.shadowBlur,
        spreadRadius: PremiumElevation.shadowSpread,
        offset: PremiumElevation.shadowOffset,
      ),
    ];
  }

  static ImageFilter lightBlur() => ImageFilter.blur(
        sigmaX: PremiumElevation.blurSigmaX,
        sigmaY: PremiumElevation.blurSigmaY,
      );
}
