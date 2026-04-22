import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:support_call_recorder/application/providers.dart';

final callMonitorBootstrapProvider = Provider<void>((ref) {
  ref.watch(callMonitorServiceProvider).start();
});
