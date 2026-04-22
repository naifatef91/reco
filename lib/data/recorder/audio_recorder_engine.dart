import 'dart:io';

import 'package:support_call_recorder/data/recorder/recorder_strategy.dart';

class AudioRecorderEngine {
  AudioRecorderEngine(this._strategies);
  final List<RecorderStrategy> _strategies;

  RecorderStrategy? _active;

  Future<String> start(File output) async {
    Object? lastError;
    for (final strategy in _strategies) {
      try {
        await strategy.start(output);
        _active = strategy;
        return strategy.sourceName;
      } catch (error) {
        lastError = error;
      }
    }
    throw StateError('No strategy could start: $lastError');
  }

  Future<void> stop() async {
    await _active?.stop();
    _active = null;
  }
}
