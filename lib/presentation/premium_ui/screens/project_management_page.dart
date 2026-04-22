import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/glass_card.dart';

class ProjectManagementPage extends StatelessWidget {
  const ProjectManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final projects = <({String name, String progress, int members})>[
      (name: l10n.premiumProjectSaasRevamp, progress: '72%', members: 6),
      (name: l10n.premiumProjectMobileOnboarding, progress: '48%', members: 4),
      (name: l10n.premiumProjectDataInsights, progress: '91%', members: 5),
    ];

    return ListView.separated(
      padding: PremiumSpacing.screenPadding,
      itemBuilder: (_, index) {
        final p = projects[index];
        return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: PremiumTypographyScale.bold),
              ),
              const SizedBox(height: PremiumSpacing.xs),
              LinearProgressIndicator(
                value: (double.tryParse(p.progress.replaceAll('%', '')) ?? 0) /
                    100,
                minHeight: 8,
                borderRadius: BorderRadius.circular(PremiumRadius.pill),
              ),
              const SizedBox(height: PremiumSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(l10n.premiumProjectCompleteWithProgress(p.progress)),
                  Text(l10n.premiumMembersCount(p.members)),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: PremiumSpacing.md),
      itemCount: projects.length,
    );
  }
}
