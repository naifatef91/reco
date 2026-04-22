import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:support_call_recorder/main.dart';

void main() {
  testWidgets('App boots to legal notice route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SupportCallRecorderApp()));
    await tester.pumpAndSettle();
    expect(find.text('Recording Consent'), findsOneWidget);
  });
}
