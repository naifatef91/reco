# Support Call Recorder (Flutter)

Android-first Flutter application for support teams that need local call recording workflows.

## MVP Delivered
- Automatic call start/end monitoring using `phone_state`.
- Recorder engine with fallback strategies (`voice_call` then `mic_fallback`).
- Local metadata storage in SQLite (`sqflite`).
- Encrypted audio-at-rest with AES before persistence.
- Legal consent gate before entering the app.
- Support UI: recordings list, search, details, playback, note/status updates.

## Run
1. `flutter pub get`
2. `flutter run`

## Notes
- Android OEM restrictions can block full two-way recording.
- The app preserves a fallback recorder source in metadata for audit/troubleshooting.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
