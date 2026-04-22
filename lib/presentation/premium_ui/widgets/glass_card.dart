import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/premium_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(PremiumSpacing.lg),
    this.radius = PremiumRadius.lg,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: PremiumTheme.lightBlur(),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: PremiumOpacity.glassCard),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: PremiumColors.cardBorder, width: 1),
            boxShadow: PremiumTheme.softShadow(),
          ),
          child: child,
        ),
      ),
    );
  }
}
