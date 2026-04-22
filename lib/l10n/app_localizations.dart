import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Call Recorder'**
  String get appTitle;

  /// No description provided for @legalTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording Consent'**
  String get legalTitle;

  /// No description provided for @legalNotice.
  ///
  /// In en, this message translates to:
  /// **'You must comply with your local laws and notify all call participants before recording.'**
  String get legalNotice;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'I Understand and Continue'**
  String get continueButton;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Please grant all required permissions to continue.'**
  String get permissionDenied;

  /// No description provided for @permissionPermanentlyDenied.
  ///
  /// In en, this message translates to:
  /// **'Some permissions are permanently denied. Open app settings.'**
  String get permissionPermanentlyDenied;

  /// No description provided for @requestingPermissions.
  ///
  /// In en, this message translates to:
  /// **'Requesting permissions...'**
  String get requestingPermissions;

  /// No description provided for @recordingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Recordings'**
  String get recordingsTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by number or note'**
  String get searchHint;

  /// No description provided for @loadErrorWithReason.
  ///
  /// In en, this message translates to:
  /// **'Failed to load: {reason}'**
  String loadErrorWithReason(Object reason);

  /// No description provided for @noRecordingsYet.
  ///
  /// In en, this message translates to:
  /// **'No recordings yet'**
  String get noRecordingsYet;

  /// No description provided for @recordingDetails.
  ///
  /// In en, this message translates to:
  /// **'Recording Details'**
  String get recordingDetails;

  /// No description provided for @recordingNotFound.
  ///
  /// In en, this message translates to:
  /// **'Recording not found'**
  String get recordingNotFound;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @recorderLabel.
  ///
  /// In en, this message translates to:
  /// **'Recorder'**
  String get recorderLabel;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @supportNote.
  ///
  /// In en, this message translates to:
  /// **'Support note'**
  String get supportNote;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get saveNote;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareFromWithPath.
  ///
  /// In en, this message translates to:
  /// **'Share file from: {path}'**
  String shareFromWithPath(Object path);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @appSecurity.
  ///
  /// In en, this message translates to:
  /// **'App security'**
  String get appSecurity;

  /// No description provided for @useBiometric.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face unlock'**
  String get useBiometric;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device'**
  String get biometricNotAvailable;

  /// No description provided for @biometricEnableFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric security was not enabled'**
  String get biometricEnableFailed;

  /// No description provided for @unlockTitle.
  ///
  /// In en, this message translates to:
  /// **'App Locked'**
  String get unlockTitle;

  /// No description provided for @unlockMessage.
  ///
  /// In en, this message translates to:
  /// **'Verify with fingerprint or face'**
  String get unlockMessage;

  /// No description provided for @unlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock app'**
  String get unlockButton;

  /// No description provided for @secondsShort.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get secondsShort;

  /// No description provided for @unknownErrorWithReason.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred: {reason}'**
  String unknownErrorWithReason(Object reason);

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get statusNew;

  /// No description provided for @statusInReview.
  ///
  /// In en, this message translates to:
  /// **'In review'**
  String get statusInReview;

  /// No description provided for @statusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get statusResolved;

  /// No description provided for @premiumWorkspaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium Workspace'**
  String get premiumWorkspaceTitle;

  /// No description provided for @premiumNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get premiumNavDashboard;

  /// No description provided for @premiumNavProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get premiumNavProjects;

  /// No description provided for @premiumNavTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get premiumNavTasks;

  /// No description provided for @premiumNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get premiumNavProfile;

  /// No description provided for @premiumAddTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get premiumAddTask;

  /// No description provided for @premiumAddTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get premiumAddTaskTitle;

  /// No description provided for @premiumTaskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get premiumTaskTitleLabel;

  /// No description provided for @premiumTaskTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Write a concise and clear title'**
  String get premiumTaskTitleHint;

  /// No description provided for @premiumProjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get premiumProjectLabel;

  /// No description provided for @premiumProjectHint.
  ///
  /// In en, this message translates to:
  /// **'Example: SaaS Revamp'**
  String get premiumProjectHint;

  /// No description provided for @premiumCreateTask.
  ///
  /// In en, this message translates to:
  /// **'Create task'**
  String get premiumCreateTask;

  /// No description provided for @premiumGeneralProject.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get premiumGeneralProject;

  /// No description provided for @premiumDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track outcomes, team focus, and delivery speed in one premium overview.'**
  String get premiumDashboardSubtitle;

  /// No description provided for @premiumThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get premiumThisWeek;

  /// No description provided for @premiumCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'86% completion rate'**
  String get premiumCompletionRate;

  /// No description provided for @premiumTasksShippedSummary.
  ///
  /// In en, this message translates to:
  /// **'12 tasks shipped, 3 in review'**
  String get premiumTasksShippedSummary;

  /// No description provided for @premiumStatActiveProjects.
  ///
  /// In en, this message translates to:
  /// **'Active Projects'**
  String get premiumStatActiveProjects;

  /// No description provided for @premiumStatOpenTasks.
  ///
  /// In en, this message translates to:
  /// **'Open Tasks'**
  String get premiumStatOpenTasks;

  /// No description provided for @premiumStatTeamVelocity.
  ///
  /// In en, this message translates to:
  /// **'Team Velocity'**
  String get premiumStatTeamVelocity;

  /// No description provided for @premiumStatOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get premiumStatOverdue;

  /// No description provided for @premiumProjectSaasRevamp.
  ///
  /// In en, this message translates to:
  /// **'SaaS Revamp'**
  String get premiumProjectSaasRevamp;

  /// No description provided for @premiumProjectMobileOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Mobile Onboarding'**
  String get premiumProjectMobileOnboarding;

  /// No description provided for @premiumProjectDataInsights.
  ///
  /// In en, this message translates to:
  /// **'Data Insights'**
  String get premiumProjectDataInsights;

  /// No description provided for @premiumProjectCompleteWithProgress.
  ///
  /// In en, this message translates to:
  /// **'{progress} complete'**
  String premiumProjectCompleteWithProgress(Object progress);

  /// No description provided for @premiumMembersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String premiumMembersCount(Object count);

  /// No description provided for @premiumNoTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get premiumNoTasksYet;

  /// No description provided for @premiumNoTasksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your first task to start a focused workflow.'**
  String get premiumNoTasksSubtitle;

  /// No description provided for @premiumProfileName.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Mansour'**
  String get premiumProfileName;

  /// No description provided for @premiumProfileRole.
  ///
  /// In en, this message translates to:
  /// **'Product Lead'**
  String get premiumProfileRole;

  /// No description provided for @premiumNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get premiumNotifications;

  /// No description provided for @premiumAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get premiumAppearance;

  /// No description provided for @premiumPrivacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get premiumPrivacySecurity;

  /// No description provided for @premiumHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get premiumHelpCenter;

  /// No description provided for @premiumTaskFinalizeSprintReport.
  ///
  /// In en, this message translates to:
  /// **'Finalize sprint report'**
  String get premiumTaskFinalizeSprintReport;

  /// No description provided for @premiumTaskReviewLandingHeroCopy.
  ///
  /// In en, this message translates to:
  /// **'Review landing hero copy'**
  String get premiumTaskReviewLandingHeroCopy;

  /// No description provided for @premiumTaskSyncAnalyticsNaming.
  ///
  /// In en, this message translates to:
  /// **'Sync analytics naming'**
  String get premiumTaskSyncAnalyticsNaming;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
