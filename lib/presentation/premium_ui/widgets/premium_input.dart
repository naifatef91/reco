import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';

class PremiumInput extends StatefulWidget {
  const PremiumInput({
    required this.label,
    super.key,
    this.controller,
    this.hintText,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;

  @override
  State<PremiumInput> createState() => _PremiumInputState();
}

class _PremiumInputState extends State<PremiumInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: AnimatedContainer(
        duration: PremiumDurations.normal,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(PremiumRadius.md),
          boxShadow: _isFocused
              ? <BoxShadow>[
                  BoxShadow(
                    color: scheme.primary
                        .withValues(alpha: PremiumOpacity.focusGlow),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
          ),
        ),
      ),
    );
  }
}
