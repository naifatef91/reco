import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:support_call_recorder/application/providers.dart';
import 'package:support_call_recorder/presentation/recordings/legal_notice_page.dart';
import 'package:support_call_recorder/presentation/recordings/recording_details_page.dart';
import 'package:support_call_recorder/presentation/recordings/recordings_list_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(appSettingsProvider);
  return GoRouter(
    initialLocation: '/recordings',
    redirect: (_, state) {
      if (!settings.initialized) return null;
      final onLegalPage = state.matchedLocation == '/legal';
      if (!settings.legalConsentAccepted && !onLegalPage) {
        return '/legal';
      }
      if (settings.legalConsentAccepted && onLegalPage) {
        return '/recordings';
      }
      return null;
    },
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
