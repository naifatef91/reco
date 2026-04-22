import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/premium_theme.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/glass_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return ListView(
      padding: PremiumSpacing.screenPadding,
      children: <Widget>[
        Text(l10n.premiumNavDashboard,
            style: text.headlineMedium
                ?.copyWith(fontWeight: PremiumTypographyScale.bold)),
        const SizedBox(height: 6),
        Text(
          l10n.premiumDashboardSubtitle,
          style: text.bodyMedium?.copyWith(color: PremiumColors.textSecondary),
        ),
        const SizedBox(height: PremiumSpacing.xl),
        Container(
          padding: const EdgeInsets.all(PremiumSpacing.xxl),
          decoration: BoxDecoration(
            gradient: PremiumTheme.primaryGradient,
            borderRadius: BorderRadius.circular(PremiumRadius.xl),
            boxShadow: PremiumTheme.softShadow(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.premiumThisWeek,
                style: TextStyle(
                  color:
                      Colors.white.withValues(alpha: PremiumOpacity.whiteMuted),
                ),
              ),
              SizedBox(height: 8),
              Text(
                l10n.premiumCompletionRate,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: PremiumTypographyScale.hero,
                    fontWeight: PremiumTypographyScale.bold),
              ),
              SizedBox(height: 6),
              Text(l10n.premiumTasksShippedSummary,
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: PremiumOpacity.whiteMuted),
                  )),
            ],
          ),
        ),
        const SizedBox(height: PremiumSpacing.lg),
        Row(
          children: <Widget>[
            Expanded(child: _StatCard(title: l10n.premiumStatActiveProjects, value: '09')),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(title: l10n.premiumStatOpenTasks, value: '28')),
          ],
        ),
        const SizedBox(height: PremiumSpacing.md),
        Row(
          children: <Widget>[
            Expanded(child: _StatCard(title: l10n.premiumStatTeamVelocity, value: '+14%')),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(title: l10n.premiumStatOverdue, value: '03')),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: PremiumSpacing.sm),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: PremiumTypographyScale.bold),
          ),
        ],
      ),
    );
  }
}
