// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مسجل مكالمات الدعم';

  @override
  String get legalTitle => 'موافقة التسجيل';

  @override
  String get legalNotice =>
      'يُرجى الالتزام بالقوانين المحلية وإبلاغ جميع المشاركين في المكالمة قبل بدء التسجيل.';

  @override
  String get continueButton => 'أوافق وأتابع';

  @override
  String get permissionDenied => 'يُرجى منح جميع الأذونات المطلوبة للمتابعة.';

  @override
  String get permissionPermanentlyDenied =>
      'تم رفض بعض الأذونات بشكل دائم. يُرجى فتح إعدادات التطبيق وتفعيلها.';

  @override
  String get requestingPermissions => 'جارٍ طلب الأذونات...';

  @override
  String get recordingsTitle => 'تسجيلات الدعم';

  @override
  String get searchHint => 'ابحث برقم الهاتف أو الملاحظة';

  @override
  String loadErrorWithReason(Object reason) {
    return 'تعذر التحميل: $reason';
  }

  @override
  String get noRecordingsYet => 'لا توجد تسجيلات بعد';

  @override
  String get recordingDetails => 'تفاصيل التسجيل';

  @override
  String get recordingNotFound => 'التسجيل غير موجود';

  @override
  String get phoneLabel => 'الهاتف';

  @override
  String get recorderLabel => 'المسجل';

  @override
  String get play => 'تشغيل';

  @override
  String get stop => 'إيقاف';

  @override
  String get supportNote => 'ملاحظة الدعم';

  @override
  String get saveNote => 'حفظ الملاحظة';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get saved => 'تم الحفظ';

  @override
  String get share => 'مشاركة';

  @override
  String shareFromWithPath(Object path) {
    return 'يمكن مشاركة الملف من: $path';
  }

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get appSecurity => 'أمان التطبيق';

  @override
  String get useBiometric => 'استخدام بصمة الإصبع أو التحقق بالوجه';

  @override
  String get excludedNumbers => 'الأرقام المستثناة';

  @override
  String get excludedNumbersHint =>
      'لن يتم تسجيل المكالمات الواردة أو الصادرة لهذه الأرقام.';

  @override
  String get noExcludedNumbers => 'لا توجد أرقام مستثناة بعد';

  @override
  String get addExcludedNumber => 'إضافة رقم مستثنى';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get excludedNumberExample => 'مثال: +201234567890';

  @override
  String get biometricNotAvailable =>
      'المصادقة الحيوية غير متاحة على هذا الجهاز';

  @override
  String get biometricEnableFailed => 'تعذّر تفعيل الحماية البيومترية';

  @override
  String get unlockTitle => 'التطبيق مقفل';

  @override
  String get unlockMessage => 'يُرجى التحقق ببصمة الإصبع أو الوجه للمتابعة';

  @override
  String get unlockButton => 'فتح التطبيق';

  @override
  String get secondsShort => 'ث';

  @override
  String unknownErrorWithReason(Object reason) {
    return 'حدث خطأ غير متوقع: $reason';
  }

  @override
  String get statusNew => 'جديد';

  @override
  String get statusInReview => 'قيد المراجعة';

  @override
  String get statusResolved => 'تم الحل';

  @override
  String get premiumWorkspaceTitle => 'مساحة العمل المتقدمة';

  @override
  String get premiumNavDashboard => 'لوحة التحكم';

  @override
  String get premiumNavProjects => 'المشاريع';

  @override
  String get premiumNavTasks => 'المهام';

  @override
  String get premiumNavProfile => 'الملف الشخصي';

  @override
  String get premiumAddTask => 'إضافة مهمة';

  @override
  String get premiumAddTaskTitle => 'إضافة مهمة';

  @override
  String get premiumTaskTitleLabel => 'عنوان المهمة';

  @override
  String get premiumTaskTitleHint => 'اكتب عنوانًا واضحًا ومختصرًا';

  @override
  String get premiumProjectLabel => 'المشروع';

  @override
  String get premiumProjectHint => 'مثال: تطوير منصة SaaS';

  @override
  String get premiumCreateTask => 'إنشاء المهمة';

  @override
  String get premiumGeneralProject => 'عام';

  @override
  String get premiumDashboardSubtitle =>
      'تابع النتائج وتركيز الفريق وسرعة الإنجاز ضمن نظرة احترافية موحدة.';

  @override
  String get premiumThisWeek => 'هذا الأسبوع';

  @override
  String get premiumCompletionRate => 'معدل الإنجاز 86٪';

  @override
  String get premiumTasksShippedSummary =>
      'تم تسليم 12 مهمة، و3 مهام قيد المراجعة';

  @override
  String get premiumStatActiveProjects => 'المشاريع النشطة';

  @override
  String get premiumStatOpenTasks => 'المهام المفتوحة';

  @override
  String get premiumStatTeamVelocity => 'سرعة الفريق';

  @override
  String get premiumStatOverdue => 'المهام المتأخرة';

  @override
  String get premiumProjectSaasRevamp => 'تطوير منصة SaaS';

  @override
  String get premiumProjectMobileOnboarding => 'تهيئة المستخدم للتطبيق';

  @override
  String get premiumProjectDataInsights => 'تحليلات البيانات';

  @override
  String premiumProjectCompleteWithProgress(Object progress) {
    return 'مكتمل بنسبة $progress';
  }

  @override
  String premiumMembersCount(Object count) {
    return '$count أعضاء';
  }

  @override
  String get premiumNoTasksYet => 'لا توجد مهام بعد';

  @override
  String get premiumNoTasksSubtitle =>
      'أنشئ مهمتك الأولى لبدء سير عمل أكثر تركيزًا.';

  @override
  String get premiumProfileName => 'أحمد منصور';

  @override
  String get premiumProfileRole => 'قائد المنتج';

  @override
  String get premiumNotifications => 'الإشعارات';

  @override
  String get premiumAppearance => 'المظهر';

  @override
  String get premiumPrivacySecurity => 'الخصوصية والأمان';

  @override
  String get premiumHelpCenter => 'مركز المساعدة';

  @override
  String get premiumTaskFinalizeSprintReport => 'إنهاء تقرير السبرنت';

  @override
  String get premiumTaskReviewLandingHeroCopy => 'مراجعة نص الواجهة الرئيسية';

  @override
  String get premiumTaskSyncAnalyticsNaming => 'توحيد تسمية أحداث التحليلات';
}
