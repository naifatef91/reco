import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';

class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate>
    with WidgetsBindingObserver {
  bool _isUnlocked = false;
  bool _isAuthenticating = false;
  bool _wasBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureUnlocked());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final settings = ref.read(appSettingsProvider);
      if (settings.biometricEnabled) {
        setState(() => _isUnlocked = false);
        _ensureUnlocked();
      }
    }
  }

  Future<void> _ensureUnlocked() async {
    final settings = ref.read(appSettingsProvider);
    if (!settings.biometricEnabled) {
      if (mounted) setState(() => _isUnlocked = true);
      return;
    }
    if (_isAuthenticating) return;
    _isAuthenticating = true;
    final success = await ref.read(biometricAuthServiceProvider).authenticate();
    _isAuthenticating = false;
    if (!mounted) return;
    setState(() => _isUnlocked = success);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final settings = ref.watch(appSettingsProvider);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (settings.biometricEnabled && !_wasBiometricEnabled) {
      _wasBiometricEnabled = true;
      if (_isUnlocked) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() => _isUnlocked = false);
          _ensureUnlocked();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) => _ensureUnlocked());
      }
    } else if (!settings.biometricEnabled) {
      _wasBiometricEnabled = false;
    }

    if (!settings.biometricEnabled || _isUnlocked) {
      return widget.child;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock, size: 52),
              const SizedBox(height: 12),
              Text(strings.unlockTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(strings.unlockMessage, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                style: isArabic
                    ? FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                      )
                    : null,
                onPressed: _ensureUnlocked,
                child: Text(strings.unlockButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
