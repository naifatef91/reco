import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/premium_theme.dart';

class PremiumButton extends StatefulWidget {
  const PremiumButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) => setState(() => _isPressed = false),
      child: AnimatedScale(
        duration: PremiumDurations.fast,
        curve: Curves.easeOutCubic,
        scale: _isPressed ? 0.985 : 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: PremiumTheme.primaryGradient,
            borderRadius: BorderRadius.circular(PremiumRadius.lg),
            boxShadow: PremiumTheme.softShadow(),
          ),
          child: widget.icon == null
              ? ElevatedButton(
                  onPressed: widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  child: Text(widget.label),
                )
              : ElevatedButton.icon(
                  onPressed: widget.onPressed,
                  icon: Icon(widget.icon, size: 18),
                  label: Text(widget.label),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                ),
        ),
      ),
    );
  }
}
