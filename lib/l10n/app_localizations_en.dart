// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Support Call Recorder';

  @override
  String get legalTitle => 'Recording Consent';

  @override
  String get legalNotice =>
      'You must comply with your local laws and notify all call participants before recording.';

  @override
  String get continueButton => 'I Understand and Continue';

  @override
  String get permissionDenied =>
      'Please grant all required permissions to continue.';

  @override
  String get permissionPermanentlyDenied =>
      'Some permissions are permanently denied. Open app settings.';

  @override
  String get requestingPermissions => 'Requesting permissions...';

  @override
  String get recordingsTitle => 'Support Recordings';

  @override
  String get searchHint => 'Search by number or note';

  @override
  String loadErrorWithReason(Object reason) {
    return 'Failed to load: $reason';
  }

  @override
  String get noRecordingsYet => 'No recordings yet';

  @override
  String get recordingDetails => 'Recording Details';

  @override
  String get recordingNotFound => 'Recording not found';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get recorderLabel => 'Recorder';

  @override
  String get play => 'Play';

  @override
  String get stop => 'Stop';

  @override
  String get supportNote => 'Support note';

  @override
  String get saveNote => 'Save note';

  @override
  String get saved => 'Saved';

  @override
  String get share => 'Share';

  @override
  String shareFromWithPath(Object path) {
    return 'Share file from: $path';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get appSecurity => 'App security';

  @override
  String get useBiometric => 'Use fingerprint or face unlock';

  @override
  String get biometricNotAvailable =>
      'Biometric authentication is not available on this device';

  @override
  String get biometricEnableFailed => 'Biometric security was not enabled';

  @override
  String get unlockTitle => 'App Locked';

  @override
  String get unlockMessage => 'Verify with fingerprint or face';

  @override
  String get unlockButton => 'Unlock app';

  @override
  String get secondsShort => 's';

  @override
  String unknownErrorWithReason(Object reason) {
    return 'Unexpected error occurred: $reason';
  }

  @override
  String get statusNew => 'New';

  @override
  String get statusInReview => 'In review';

  @override
  String get statusResolved => 'Resolved';

  @override
  String get premiumWorkspaceTitle => 'Premium Workspace';

  @override
  String get premiumNavDashboard => 'Dashboard';

  @override
  String get premiumNavProjects => 'Projects';

  @override
  String get premiumNavTasks => 'Tasks';

  @override
  String get premiumNavProfile => 'Profile';

  @override
  String get premiumAddTask => 'Add Task';

  @override
  String get premiumAddTaskTitle => 'Add task';

  @override
  String get premiumTaskTitleLabel => 'Task title';

  @override
  String get premiumTaskTitleHint => 'Write a concise and clear title';

  @override
  String get premiumProjectLabel => 'Project';

  @override
  String get premiumProjectHint => 'Example: SaaS Revamp';

  @override
  String get premiumCreateTask => 'Create task';

  @override
  String get premiumGeneralProject => 'General';

  @override
  String get premiumDashboardSubtitle =>
      'Track outcomes, team focus, and delivery speed in one premium overview.';

  @override
  String get premiumThisWeek => 'This week';

  @override
  String get premiumCompletionRate => '86% completion rate';

  @override
  String get premiumTasksShippedSummary => '12 tasks shipped, 3 in review';

  @override
  String get premiumStatActiveProjects => 'Active Projects';

  @override
  String get premiumStatOpenTasks => 'Open Tasks';

  @override
  String get premiumStatTeamVelocity => 'Team Velocity';

  @override
  String get premiumStatOverdue => 'Overdue';

  @override
  String get premiumProjectSaasRevamp => 'SaaS Revamp';

  @override
  String get premiumProjectMobileOnboarding => 'Mobile Onboarding';

  @override
  String get premiumProjectDataInsights => 'Data Insights';

  @override
  String premiumProjectCompleteWithProgress(Object progress) {
    return '$progress complete';
  }

  @override
  String premiumMembersCount(Object count) {
    return '$count members';
  }

  @override
  String get premiumNoTasksYet => 'No tasks yet';

  @override
  String get premiumNoTasksSubtitle =>
      'Create your first task to start a focused workflow.';

  @override
  String get premiumProfileName => 'Ahmed Mansour';

  @override
  String get premiumProfileRole => 'Product Lead';

  @override
  String get premiumNotifications => 'Notifications';

  @override
  String get premiumAppearance => 'Appearance';

  @override
  String get premiumPrivacySecurity => 'Privacy & Security';

  @override
  String get premiumHelpCenter => 'Help Center';

  @override
  String get premiumTaskFinalizeSprintReport => 'Finalize sprint report';

  @override
  String get premiumTaskReviewLandingHeroCopy => 'Review landing hero copy';

  @override
  String get premiumTaskSyncAnalyticsNaming => 'Sync analytics naming';
}
