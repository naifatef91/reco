import 'dart:io';

import 'package:record/record.dart';
import 'package:support_call_recorder/data/recorder/recorder_strategy.dart';

class MicRecorderStrategy implements RecorderStrategy {
  MicRecorderStrategy(this._recorder);
  final AudioRecorder _recorder;

  @override
  String get sourceName => 'mic_fallback';

  @override
  Future<void> start(File output) async {
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: output.path,
    );
  }

  @override
  Future<void> stop() async {
    await _recorder.stop();
  }
}
