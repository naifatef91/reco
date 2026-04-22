import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/glass_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: PremiumSpacing.screenPadding,
      children: <Widget>[
        GlassCard(
          child: Row(
            children: <Widget>[
              const CircleAvatar(radius: 28, child: Text('AM')),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.premiumProfileName,
                      style: const TextStyle(
                          fontWeight: PremiumTypographyScale.bold)),
                  Text(l10n.premiumProfileRole),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: PremiumSpacing.md),
        ...<Widget>[
          _SettingTile(
              icon: Icons.notifications_none_rounded, title: l10n.premiumNotifications),
          const SizedBox(height: PremiumSpacing.sm),
          _SettingTile(icon: Icons.palette_outlined, title: l10n.premiumAppearance),
          const SizedBox(height: PremiumSpacing.sm),
          _SettingTile(
              icon: Icons.security_outlined, title: l10n.premiumPrivacySecurity),
          const SizedBox(height: PremiumSpacing.sm),
          _SettingTile(icon: Icons.help_outline, title: l10n.premiumHelpCenter),
        ],
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: PremiumSpacing.sm),
          Expanded(child: Text(title)),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
