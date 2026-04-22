import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/l10n/app_localizations.dart';
import 'package:support_call_recorder/presentation/app_router.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/premium_theme.dart';
import 'package:support_call_recorder/presentation/call_monitor_bootstrap.dart';
import 'package:support_call_recorder/presentation/security/app_lock_gate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SupportCallRecorderApp()));
}

class SupportCallRecorderApp extends ConsumerWidget {
  const SupportCallRecorderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(callMonitorBootstrapProvider);
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(appSettingsProvider);
    final isArabic = settings.locale.languageCode == 'ar';
    final baseTheme = PremiumTheme.light();
    final themedTypography = isArabic
        ? GoogleFonts.cairoTextTheme(baseTheme.textTheme)
        : GoogleFonts.interTextTheme(baseTheme.textTheme);
    final adjustedTypography = isArabic
        ? themedTypography.copyWith(
            titleLarge: themedTypography.titleLarge?.copyWith(
              fontSize: (themedTypography.titleLarge?.fontSize ?? 22) + 1,
              fontWeight: FontWeight.w700,
            ),
            titleMedium: themedTypography.titleMedium?.copyWith(
              fontSize: (themedTypography.titleMedium?.fontSize ?? 16) + 0.5,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: themedTypography.headlineSmall?.copyWith(
              fontSize: (themedTypography.headlineSmall?.fontSize ?? 24) + 1,
              fontWeight: FontWeight.w700,
            ),
          )
        : themedTypography;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: baseTheme.copyWith(
        textTheme: adjustedTypography,
        primaryTextTheme: adjustedTypography,
      ),
      routerConfig: router,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) =>
          AppLockGate(child: child ?? const SizedBox.shrink()),
    );
  }
}
