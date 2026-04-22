import 'package:flutter/material.dart';

@immutable
class PremiumSpacing {
  const PremiumSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 10;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 20;
  static const double screenH = 20;
  static const double bottomNavMargin = 18;
  static const EdgeInsets screenPadding =
      EdgeInsets.fromLTRB(screenH, md, screenH, 120);
}

@immutable
class PremiumRadius {
  const PremiumRadius._();

  static const double sm = 10;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 99;
}

@immutable
class PremiumDurations {
  const PremiumDurations._();

  static const Duration fast = Duration(milliseconds: 140);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 220);
  static const Duration loading = Duration(milliseconds: 1200);
}

@immutable
class PremiumOpacity {
  const PremiumOpacity._();

  static const double whiteMuted = 0.7;
  static const double glassCard = 0.58;
  static const double glassCardTheme = 0.65;
  static const double inputFill = 0.8;
  static const double inputBorder = 0.9;
  static const double focusGlow = 0.16;
  static const double navBackground = 0.88;
  static const double indicator = 0.25;
}

@immutable
class PremiumElevation {
  const PremiumElevation._();

  static const Color shadowColor = Color(0x1A1E3A8A);
  static const double shadowBlur = 20;
  static const double shadowSpread = 0;
  static const Offset shadowOffset = Offset(0, 10);
  static const double blurSigmaX = 16;
  static const double blurSigmaY = 16;
}

@immutable
class PremiumTypographyScale {
  const PremiumTypographyScale._();

  static const double hero = 24;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
