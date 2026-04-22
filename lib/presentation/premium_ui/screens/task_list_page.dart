import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/premium_ui/models/task_item.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/glass_card.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/skeleton_block.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    required this.tasks,
    required this.isLoading,
    required this.onToggle,
    super.key,
  });

  final List<TaskItem> tasks;
  final bool isLoading;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (isLoading) {
      return ListView(
        padding: PremiumSpacing.screenPadding,
        children: List<Widget>.generate(5, (_) => const _TaskSkeleton()),
      );
    }

    if (tasks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(PremiumSpacing.xxl + PremiumSpacing.xs),
          child: GlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.inbox_outlined, size: 36),
                const SizedBox(height: PremiumSpacing.sm),
                Text(
                  l10n.premiumNoTasksYet,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: PremiumTypographyScale.bold),
                ),
                const SizedBox(height: PremiumSpacing.xxs),
                Text(l10n.premiumNoTasksSubtitle),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: PremiumSpacing.screenPadding,
      itemBuilder: (_, index) {
        final task = tasks[index];
        return AnimatedSwitcher(
          duration: PremiumDurations.normal,
          child: GlassCard(
            key: ValueKey('${task.title}-${task.isDone}'),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: task.isDone,
                  onChanged: (_) => onToggle(index),
                ),
                const SizedBox(width: PremiumSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                      Text(task.project,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: PremiumSpacing.sm),
      itemCount: tasks.length,
    );
  }
}

class _TaskSkeleton extends StatelessWidget {
  const _TaskSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: PremiumSpacing.sm),
      child: GlassCard(
        child: Row(
          children: <Widget>[
            SkeletonBlock(height: 20, width: 20, radius: 6),
            SizedBox(width: PremiumSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SkeletonBlock(height: 14, width: 140),
                  SizedBox(height: PremiumSpacing.xs),
                  SkeletonBlock(height: 12, width: 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
