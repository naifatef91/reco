import 'dart:io';

abstract class RecorderStrategy {
  String get sourceName;
  Future<void> start(File output);
  Future<void> stop();
}
