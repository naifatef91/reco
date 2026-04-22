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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordingsControllerProvider);
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final searchPadding = isArabic ? 14.0 : 12.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.recordingsTitle),
        actions: [
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.settings),
            tooltip: strings.settings,
          ),
        ],
      ),
      body: Column(
        children: [
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

  Future<void> _openSettings() async {
    final strings = context.l10n;
    final settings = ref.read(appSettingsProvider);

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(strings.settings,
                  style: Theme.of(sheetContext).textTheme.titleLarge),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: settings.locale.languageCode,
                decoration: InputDecoration(labelText: strings.language),
                items: [
                  DropdownMenuItem(value: 'en', child: Text(strings.english)),
                  DropdownMenuItem(value: 'ar', child: Text(strings.arabic)),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  ref.read(appSettingsProvider.notifier).setLanguageCode(value);
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(strings.appSecurity),
                subtitle: Text(strings.useBiometric),
                value: settings.biometricEnabled,
                onChanged: (enabled) async {
                  if (!enabled) {
                    await ref
                        .read(appSettingsProvider.notifier)
                        .setBiometricEnabled(false);
                    if (!mounted) return;
                    setState(() {});
                    return;
                  }

                  final service = ref.read(biometricAuthServiceProvider);
                  final isAvailable = await service.isAvailable();
                  if (!isAvailable) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(strings.biometricNotAvailable)),
                    );
                    return;
                  }

                  final isAuthenticated = await service.authenticate();
                  if (!isAuthenticated) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(strings.biometricEnableFailed)),
                    );
                    return;
                  }

                  await ref
                      .read(appSettingsProvider.notifier)
                      .setBiometricEnabled(true);
                  if (!mounted) return;
                  setState(() {});
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
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
