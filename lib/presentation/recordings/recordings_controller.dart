import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/domain/model/call_recording.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';

final recordingsControllerProvider = StateNotifierProvider<RecordingsController,
    AsyncValue<List<CallRecording>>>(
  (ref) => RecordingsController(ref)..load(),
);

class RecordingsController
    extends StateNotifier<AsyncValue<List<CallRecording>>> {
  RecordingsController(this._ref) : super(const AsyncValue.loading());
  final Ref _ref;

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _ref.read(useCasesProvider).list());
  }

  Future<void> updateNote(int id, String note) async {
    await _ref.read(useCasesProvider).updateNote(id, note);
    await load();
  }

  Future<void> updateStatus(int id, SupportStatus status) async {
    await _ref.read(useCasesProvider).updateStatus(id, status);
    await load();
  }
}
