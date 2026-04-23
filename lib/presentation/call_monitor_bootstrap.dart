import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:support_call_recorder/application/providers.dart';

final callMonitorBootstrapProvider = Provider<void>((ref) {
  final settings = ref.watch(appSettingsProvider);
  final monitor = ref.watch(callMonitorServiceProvider);
  if (!settings.initialized) return;
  if (settings.legalConsentAccepted) {
    unawaited(monitor.start());
    return;
  }
  unawaited(monitor.stop());
});
