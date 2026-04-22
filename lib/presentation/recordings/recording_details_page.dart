import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/recordings/recordings_controller.dart';

class RecordingDetailsPage extends ConsumerStatefulWidget {
  const RecordingDetailsPage({super.key, required this.recordingId});
  final int recordingId;

  @override
  ConsumerState<RecordingDetailsPage> createState() =>
      _RecordingDetailsPageState();
}

class _RecordingDetailsPageState extends ConsumerState<RecordingDetailsPage> {
  final _player = AudioPlayer();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _player.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordingsControllerProvider);
    final strings = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final sectionGapSmall = isArabic ? 14.0 : 12.0;
    final sectionGapMedium = isArabic ? 20.0 : 16.0;
    final filledButtonStyle = isArabic
        ? FilledButton.styleFrom(
            minimumSize: const Size(132, 50),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          )
        : null;
    final outlinedButtonStyle = isArabic
        ? OutlinedButton.styleFrom(
            minimumSize: const Size(108, 50),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          )
        : null;
    return Scaffold(
      appBar: AppBar(title: Text(strings.recordingDetails)),
      body: state.when(
        data: (rows) {
          final item =
              rows.where((e) => e.id == widget.recordingId).firstOrNull;
          if (item == null) {
            return Center(child: Text(strings.recordingNotFound));
          }
          if (_noteController.text != item.note) {
            _noteController.text = item.note;
          }
          return Padding(
            padding: EdgeInsets.all(isArabic ? 18 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${strings.phoneLabel}: ${item.phoneNumber}'),
                Text('${strings.recorderLabel}: ${item.recorderSource}'),
                SizedBox(height: sectionGapSmall),
                Row(
                  children: [
                    FilledButton(
                      style: filledButtonStyle,
                      onPressed: () async {
                        final decrypted = await ref
                            .read(fileCryptoProvider)
                            .decryptToTemp(File(item.filePath));
                        await _player.setFilePath(decrypted.path);
                        await _player.play();
                      },
                      child: Text(strings.play),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: outlinedButtonStyle,
                      onPressed: () => _player.stop(),
                      child: Text(strings.stop),
                    ),
                  ],
                ),
                SizedBox(height: sectionGapMedium),
                TextField(
                  controller: _noteController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(labelText: strings.supportNote),
                ),
                SizedBox(height: sectionGapSmall),
                DropdownButton<SupportStatus>(
                  value: item.status,
                  items: SupportStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.localizedLabel(strings)),
                        ),
                      )
                      .toList(),
                  onChanged: (status) async {
                    if (status == null || item.id == null) return;
                    await ref
                        .read(recordingsControllerProvider.notifier)
                        .updateStatus(item.id!, status);
                  },
                ),
                SizedBox(height: sectionGapSmall),
                FilledButton(
                  style: filledButtonStyle,
                  onPressed: () async {
                    if (item.id == null) return;
                    await ref
                        .read(recordingsControllerProvider.notifier)
                        .updateNote(item.id!, _noteController.text.trim());
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(strings.saved)));
                    }
                  },
                  child: Text(strings.saveNote),
                ),
              ],
            ),
          );
        },
        error: (e, _) =>
            Center(child: Text(strings.unknownErrorWithReason('$e'))),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final item =
              await ref.read(useCasesProvider).byId(widget.recordingId);
          if (item == null || !context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(strings.shareFromWithPath(item.filePath))),
          );
        },
        label: Text(strings.share),
        icon: const Icon(Icons.share),
      ),
    );
  }
}
