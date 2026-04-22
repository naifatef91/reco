import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';

class SkeletonBlock extends StatefulWidget {
  const SkeletonBlock({
    super.key,
    this.height = PremiumSpacing.lg,
    this.width,
    this.radius = PremiumRadius.sm,
  });

  final double height;
  final double? width;
  final double radius;

  @override
  State<SkeletonBlock> createState() => _SkeletonBlockState();
}

class _SkeletonBlockState extends State<SkeletonBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: PremiumDurations.loading,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: Color.lerp(
              const Color(0xFFE2E8F0),
              const Color(0xFFF1F5F9),
              _controller.value,
            ),
          ),
        );
      },
    );
  }
}
