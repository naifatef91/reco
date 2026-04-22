class TaskItem {
  const TaskItem({
    required this.title,
    required this.project,
    required this.isDone,
  });

  final String title;
  final String project;
  final bool isDone;

  TaskItem copyWith({
    String? title,
    String? project,
    bool? isDone,
  }) {
    return TaskItem(
      title: title ?? this.title,
      project: project ?? this.project,
      isDone: isDone ?? this.isDone,
    );
  }
}
