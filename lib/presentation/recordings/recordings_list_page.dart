import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/recordings/recordings_controller.dart';

class RecordingsListPage extends ConsumerStatefulWidget {
  const RecordingsListPage({super.key});

  @override
  ConsumerState<RecordingsListPage> createState() => _RecordingsListPageState();
}

class _RecordingsListPageState extends ConsumerState<RecordingsListPage> {
  String _query = '';
  bool _handledNotificationStopRequest = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleNotificationStopRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordingsControllerProvider);
    final activeRecordingAsync = ref.watch(activeRecordingStateProvider);
    final activeRecording = activeRecordingAsync.value ??
        ref.read(callMonitorServiceProvider).currentRecordingState;
    final isRecording = activeRecording.isRecording;
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final searchPadding = isArabic ? 14.0 : 12.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.recordingsTitle),
        actions: [
          if (isRecording)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Tooltip(
                message:
                    isArabic ? 'المكالمة قيد التسجيل' : 'Call is being recorded',
                child: const Icon(Icons.fiber_manual_record, color: Colors.red),
              ),
            ),
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.settings),
            tooltip: strings.settings,
          ),
        ],
      ),
      body: Column(
        children: [
          if (isRecording)
            _RecordingActiveBanner(
              phoneNumber: activeRecording.phoneNumber,
              onStop: _stopActiveRecording,
            ),
          Padding(
            padding: EdgeInsets.all(searchPadding),
            child: TextField(
              decoration: InputDecoration(
                hintText: strings.searchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            ),
          ),
          Expanded(
            child: state.when(
              data: (rows) => _List(
                recordings: rows.where(_matchesQuery).toList(),
              ),
              error: (e, _) =>
                  Center(child: Text(strings.loadErrorWithReason('$e'))),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  bool _matchesQuery(CallRecording recording) {
    if (_query.isEmpty) return true;
    return recording.phoneNumber.toLowerCase().contains(_query) ||
        recording.note.toLowerCase().contains(_query);
  }

  Future<void> _stopActiveRecording() async {
    final localeIsArabic = isArabic(context);
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(callMonitorServiceProvider).stopActiveRecording();
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(localeIsArabic ? 'تم إيقاف التسجيل' : 'Recording stopped'),
      ),
    );
    ref.invalidate(recordingsControllerProvider);
  }

  bool isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar';

  Future<void> _handleNotificationStopRequest() async {
    if (_handledNotificationStopRequest) return;
    _handledNotificationStopRequest = true;
    final shouldStop = await ref
        .read(nativeCallBridgeProvider)
        .consumePendingStopRecordingRequest();
    if (!shouldStop) return;
    await _stopActiveRecording();
  }

  Future<void> _openSettings() async {
    final strings = context.l10n;
    final settings = ref.read(appSettingsProvider);
    final excludedNumbers = List<String>.from(settings.excludedNumbers);
    var biometricEnabled = settings.biometricEnabled;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  strings.settings,
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  strings.language,
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                        color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: Theme.of(sheetContext).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: settings.locale.languageCode,
                            decoration: InputDecoration(
                              labelText: strings.language,
                              border: const OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text(strings.english),
                              ),
                              DropdownMenuItem(
                                value: 'ar',
                                child: Text(strings.arabic),
                              ),
                            ],
                            onChanged: (value) {
                              if (value == null) return;
                              ref
                                  .read(appSettingsProvider.notifier)
                                  .setLanguageCode(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.appSecurity,
                  style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                        color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                    Card(
                      margin: EdgeInsets.zero,
                      child: SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        secondary: Icon(
                          Icons.fingerprint,
                          color: Theme.of(sheetContext).colorScheme.primary,
                        ),
                        title: Text(strings.appSecurity),
                        subtitle: Text(strings.useBiometric),
                        value: biometricEnabled,
                        onChanged: (enabled) async {
                          if (!enabled) {
                            await ref
                                .read(appSettingsProvider.notifier)
                                .setBiometricEnabled(false);
                            biometricEnabled = false;
                            if (!mounted) return;
                            setModalState(() {});
                            setState(() {});
                            return;
                          }

                          final service = ref.read(biometricAuthServiceProvider);
                          final isAvailable = await service.isAvailable();
                      if (!isAvailable) {
                        if (!sheetContext.mounted) return;
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                              SnackBar(content: Text(strings.biometricNotAvailable)),
                            );
                            return;
                          }

                          final isAuthenticated = await service.authenticate();
                          if (!isAuthenticated) {
                        if (!sheetContext.mounted) return;
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                              SnackBar(content: Text(strings.biometricEnableFailed)),
                            );
                            return;
                          }

                          await ref
                              .read(appSettingsProvider.notifier)
                              .setBiometricEnabled(true);
                          biometricEnabled = true;
                          if (!mounted) return;
                          setModalState(() {});
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      strings.excludedNumbers,
                      style: Theme.of(sheetContext).textTheme.bodySmall?.copyWith(
                            color: Theme.of(sheetContext)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(strings.excludedNumbersHint),
                            const SizedBox(height: 10),
                            if (excludedNumbers.isEmpty)
                              Text(
                                strings.noExcludedNumbers,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            else
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: excludedNumbers
                                    .map(
                                      (number) => InputChip(
                                        label: Text(number),
                                        onDeleted: () async {
                                          await ref
                                              .read(appSettingsProvider.notifier)
                                              .removeExcludedNumber(number);
                                          excludedNumbers.removeWhere(
                                            (item) => item == number,
                                          );
                                          setModalState(() {});
                                        },
                                      ),
                                    )
                                    .toList(growable: false),
                              ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: () async {
                                final number = await _showAddExcludedNumberDialog(
                                  sheetContext,
                                );
                                if (number == null || number.trim().isEmpty) return;
                                await ref
                                    .read(appSettingsProvider.notifier)
                                    .addExcludedNumber(number);
                                final refreshed =
                                    ref.read(appSettingsProvider).excludedNumbers;
                                excludedNumbers
                                  ..clear()
                                  ..addAll(refreshed);
                                setModalState(() {});
                              },
                              icon: const Icon(Icons.add),
                              label: Text(strings.addExcludedNumber),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> _showAddExcludedNumberDialog(BuildContext context) async {
    final strings = context.l10n;
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(strings.addExcludedNumber),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: strings.phoneNumber,
              hintText: strings.excludedNumberExample,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(strings.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(controller.text),
              child: Text(strings.save),
            ),
          ],
        );
      },
    );
    controller.dispose();
    return result;
  }
}

class _RecordingActiveBanner extends StatelessWidget {
  const _RecordingActiveBanner({
    required this.phoneNumber,
    required this.onStop,
  });

  final String phoneNumber;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.red.shade50,
        child: ListTile(
          leading: const Icon(Icons.radio_button_checked, color: Colors.red),
          title: Text(isArabic ? 'المكالمة قيد التسجيل' : 'Call recording in progress'),
          subtitle: Text(
            phoneNumber == 'unknown'
                ? (isArabic ? 'رقم غير معروف' : 'Unknown number')
                : phoneNumber,
          ),
          trailing: FilledButton.icon(
            onPressed: onStop,
            icon: const Icon(Icons.stop),
            label: Text(strings.stop),
          ),
        ),
      ),
    );
  }
}

class _List extends ConsumerWidget {
  const _List({required this.recordings});
  final List<CallRecording> recordings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMd(localeName).add_Hm();
    if (recordings.isEmpty) {
      return Center(child: Text(strings.noRecordingsYet));
    }
    return ListView.separated(
      itemCount: recordings.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) {
        final item = recordings[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isArabic ? 6 : 2,
          ),
          minVerticalPadding: isArabic ? 6 : 4,
          title: Text(item.phoneNumber),
          subtitle: Text(
            '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(item.startedAtEpochMs))} • ${Duration(milliseconds: item.durationMs).inSeconds}${strings.secondsShort}',
          ),
          trailing: Text(
            item.status.localizedLabel(strings),
            textAlign: TextAlign.end,
          ),
          onTap: () => context.push('/recordings/${item.id}'),
        );
      },
    );
  }
}
