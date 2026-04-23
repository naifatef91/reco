import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:support_call_recorder/presentation/recordings/legal_notice_page.dart';
import 'package:support_call_recorder/presentation/recordings/recording_details_page.dart';
import 'package:support_call_recorder/presentation/recordings/recordings_list_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/legal',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const RecordingsListPage(),
      ),
      GoRoute(
        path: '/legal',
        builder: (_, __) => const LegalNoticePage(),
      ),
      GoRoute(
        path: '/recordings',
        builder: (_, __) => const RecordingsListPage(),
      ),
      GoRoute(
        path: '/recordings/:id',
        builder: (_, state) => RecordingDetailsPage(
          recordingId: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );
});
