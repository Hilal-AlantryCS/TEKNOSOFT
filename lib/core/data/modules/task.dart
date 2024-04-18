import 'package:teknosoft/core/utils/sql_db_utils.dart';

enum Priority { low, medium, high }

enum Category { personal, learning, work, shopping }

class Task {
  int id;
  String title;
  DateTime startDate;
  DateTime endDate;
  Priority priority;
  Category category;
  int important;
  int completed;

  Task({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.category,
    required this.important,
    required this.completed,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[SqlDbUtils.columnId],
      title: map[SqlDbUtils.columnTitle],
      startDate: DateTime.parse(map[SqlDbUtils.columnStartDate]),
      endDate: DateTime.parse(map[SqlDbUtils.columnEndDate]),
      priority: Priority.values[map[SqlDbUtils.columnPriority]],
      category: Category.values[map[SqlDbUtils.columnCategory]],
      important: map[SqlDbUtils.columnImportant],
      completed: map[SqlDbUtils.columnCompleted],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      SqlDbUtils.columnId: id,
      SqlDbUtils.columnTitle: title,
      SqlDbUtils.columnStartDate: startDate.toString(),
      SqlDbUtils.columnEndDate: endDate.toString(),
      SqlDbUtils.columnPriority: priority.index,
      SqlDbUtils.columnCategory: category.index,
      SqlDbUtils.columnImportant: important,
      SqlDbUtils.columnCompleted: completed,
    };
  }

  static List<Task> mapToTaskList(List<Map<String, dynamic>> maps) {
    List<Task> tasks = maps.map((map) => Task.fromMap(map)).toList();
    tasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    // i reversed the task to display the high priority first
    tasks.reversed;
    return tasks;
  }

  static const Map<Category, String> mapCategorys = {
    Category.personal: 'Personal',
    Category.learning: 'Learning',
    Category.work: 'Work',
    Category.shopping: 'Shopping',
  };
  static const Map<Priority, String> mapPrioritys = {
    Priority.low: 'low',
    Priority.medium: 'medium',
    Priority.high: 'high',
  };
}
