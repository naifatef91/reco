import 'package:flutter/widgets.dart';
import 'package:support_call_recorder/domain/model/support_status.dart';
import 'package:support_call_recorder/l10n/app_localizations.dart';

extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension SupportStatusL10n on SupportStatus {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case SupportStatus.newTicket:
        return l10n.statusNew;
      case SupportStatus.inReview:
        return l10n.statusInReview;
      case SupportStatus.resolved:
        return l10n.statusResolved;
    }
  }
}
