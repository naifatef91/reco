import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';

class LegalNoticePage extends ConsumerStatefulWidget {
  const LegalNoticePage({super.key});

  @override
  ConsumerState<LegalNoticePage> createState() => _LegalNoticePageState();
}

class _LegalNoticePageState extends ConsumerState<LegalNoticePage> {
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final buttonStyle = isArabic
        ? FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          )
        : null;
    return Scaffold(
      appBar: AppBar(title: Text(strings.legalTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.legalNotice),
            const SizedBox(height: 20),
            FilledButton(
              style: buttonStyle,
              onPressed: _isRequesting
                  ? null
                  : _requestPermissionsAndContinue,
              child: Text(_isRequesting
                  ? strings.requestingPermissions
                  : strings.continueButton),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermissionsAndContinue() async {
    if (_isRequesting) return;
    setState(() => _isRequesting = true);
    final strings = context.l10n;
    final permissionResult =
        await ref.read(permissionServiceProvider).requestRequired();
    if (!mounted) return;

    if (permissionResult.allGranted) {
      await ref.read(callMonitorServiceProvider).start();
      await ref.read(appSettingsProvider.notifier).setLegalConsentAccepted(true);
      if (mounted) context.go('/recordings');
      setState(() => _isRequesting = false);
      return;
    }

    if (permissionResult.hasPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.permissionPermanentlyDenied)),
      );
      await openAppSettings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.permissionDenied)),
      );
    }
    if (mounted) {
      setState(() => _isRequesting = false);
    }
  }
}
