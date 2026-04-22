import 'dart:io';

import 'package:record/record.dart';
import 'package:support_call_recorder/data/recorder/recorder_strategy.dart';

class VoiceCallRecorderStrategy implements RecorderStrategy {
  VoiceCallRecorderStrategy(this._recorder);
  final AudioRecorder _recorder;

  @override
  String get sourceName => 'voice_call';

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
