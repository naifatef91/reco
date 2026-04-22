import 'package:flutter/material.dart';
import 'package:support_call_recorder/presentation/premium_ui/models/task_item.dart';
import 'package:support_call_recorder/presentation/localization/l10n_extensions.dart';
import 'package:support_call_recorder/presentation/premium_ui/screens/dashboard_page.dart';
import 'package:support_call_recorder/presentation/premium_ui/screens/profile_page.dart';
import 'package:support_call_recorder/presentation/premium_ui/screens/project_management_page.dart';
import 'package:support_call_recorder/presentation/premium_ui/screens/task_list_page.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/design_tokens.dart';
import 'package:support_call_recorder/presentation/premium_ui/theme/premium_theme.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/premium_button.dart';
import 'package:support_call_recorder/presentation/premium_ui/widgets/premium_input.dart';

class PremiumHomeShell extends StatefulWidget {
  const PremiumHomeShell({super.key});

  @override
  State<PremiumHomeShell> createState() => _PremiumHomeShellState();
}

class _PremiumHomeShellState extends State<PremiumHomeShell> {
  int _index = 0;
  bool _isLoadingTasks = true;
  final List<TaskItem> _tasks = <TaskItem>[];
  bool _didSeedTasks = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(PremiumDurations.loading, () {
      if (!mounted) {
        return;
      }
      setState(() => _isLoadingTasks = false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didSeedTasks) {
      return;
    }
    _didSeedTasks = true;
    _seedTasks();
  }

  void _seedTasks() {
    final l10n = context.l10n;
    _tasks.addAll(<TaskItem>[
      TaskItem(
        title: l10n.premiumTaskFinalizeSprintReport,
        project: l10n.premiumProjectSaasRevamp,
        isDone: false,
      ),
      TaskItem(
        title: l10n.premiumTaskReviewLandingHeroCopy,
        project: l10n.premiumProjectMobileOnboarding,
        isDone: false,
      ),
      TaskItem(
        title: l10n.premiumTaskSyncAnalyticsNaming,
        project: l10n.premiumProjectDataInsights,
        isDone: true,
      ),
    ]);
  }

  void _toggleTask(int i) {
    setState(() {
      _tasks[i] = _tasks[i].copyWith(isDone: !_tasks[i].isDone);
    });
  }

  Future<void> _openAddTaskModal() async {
    final l10n = context.l10n;
    final titleController = TextEditingController();
    final projectController = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: PremiumSpacing.lg,
            right: PremiumSpacing.lg,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + PremiumSpacing.lg,
            top: 24,
          ),
          child: Container(
            padding: const EdgeInsets.all(PremiumSpacing.xl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(PremiumRadius.xl),
              boxShadow: PremiumTheme.softShadow(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  l10n.premiumAddTaskTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: PremiumTypographyScale.bold),
                ),
                const SizedBox(height: PremiumSpacing.md),
                PremiumInput(
                  label: l10n.premiumTaskTitleLabel,
                  hintText: l10n.premiumTaskTitleHint,
                  controller: titleController,
                ),
                const SizedBox(height: PremiumSpacing.sm),
                PremiumInput(
                  label: l10n.premiumProjectLabel,
                  hintText: l10n.premiumProjectHint,
                  controller: projectController,
                ),
                const SizedBox(height: PremiumRadius.md),
                PremiumButton(
                  label: l10n.premiumCreateTask,
                  icon: Icons.add,
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      return;
                    }
                    setState(() {
                      _tasks.insert(
                        0,
                        TaskItem(
                          title: titleController.text.trim(),
                          project: projectController.text.trim().isEmpty
                              ? l10n.premiumGeneralProject
                              : projectController.text.trim(),
                          isDone: false,
                        ),
                      );
                      _index = 2;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    titleController.dispose();
    projectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pages = <Widget>[
      const DashboardPage(),
      const ProjectManagementPage(),
      TaskListPage(
          tasks: _tasks, isLoading: _isLoadingTasks, onToggle: _toggleTask),
      const ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.premiumWorkspaceTitle),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      extendBody: true,
      body: AnimatedSwitcher(
        duration: PremiumDurations.medium,
        child: KeyedSubtree(
          key: ValueKey<int>(_index),
          child: pages[_index],
        ),
      ),
      floatingActionButton: _index == 2
          ? FloatingActionButton.extended(
              onPressed: _openAddTaskModal,
              label: Text(l10n.premiumAddTask),
              icon: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          PremiumSpacing.bottomNavMargin,
          0,
          PremiumSpacing.bottomNavMargin,
          PremiumSpacing.bottomNavMargin,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: PremiumOpacity.navBackground),
            borderRadius: BorderRadius.circular(PremiumRadius.xl),
            boxShadow: PremiumTheme.softShadow(),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            backgroundColor: Colors.transparent,
            indicatorColor: PremiumColors.softPurple
                .withValues(alpha: PremiumOpacity.indicator),
            destinations: <Widget>[
              NavigationDestination(
                  icon: const Icon(Icons.grid_view_rounded),
                  label: l10n.premiumNavDashboard),
              NavigationDestination(
                  icon: const Icon(Icons.account_tree_outlined),
                  label: l10n.premiumNavProjects),
              NavigationDestination(
                  icon: const Icon(Icons.checklist_rounded),
                  label: l10n.premiumNavTasks),
              NavigationDestination(
                  icon: const Icon(Icons.person_outline),
                  label: l10n.premiumNavProfile),
            ],
          ),
        ),
      ),
    );
  }
}
