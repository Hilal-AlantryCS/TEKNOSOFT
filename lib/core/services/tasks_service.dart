import 'package:get/get.dart';
import 'package:teknosoft/core/data/modules/task.dart';
import 'package:teknosoft/core/utils/sql_db_utils.dart';

class TasksServices extends GetxController {
  SqlDbUtils sqlDb = SqlDbUtils();
  RxList<dynamic> tasks = [].obs;

  RxList<dynamic> filterTask = [].obs;
  Rx<DateTime> filterDate = DateTime.now().obs;

  RxList<dynamic> importantTasks = [].obs;
  RxList<dynamic> upcomingTasks = [].obs;
  RxList<dynamic> myDayTasks = [].obs;
  RxList<dynamic> progressMyDayTasks = [].obs;

  RxMap<Category, List<dynamic>> filteredTasksWithCategory = {
    Category.personal: [],
    Category.learning: [],
    Category.work: [],
    Category.shopping: [],
  }.obs;

  @override
  void onInit() {
    getTasks();
    super.onInit();
  }

  getTasks() async {
    tasks.value = Task.mapToTaskList(await sqlDb.read(table: "tasks"));

    for (var category in Category.values) {
      filteredTasksWithCategory[category] =
          tasks.where((task) => task.category == category).toList();
    }

    importantTasks.value = getImportantTasks(tasks);
    upcomingTasks.value = getUpcomingTasks(tasks);
    myDayTasks.value = getTasksInCurrentDay(tasks);

    updateFilteredUpcomingTaskOnDaySelected(filterDate.value, filterDate.value);

    progressMyDayTasks.value = filterNotCompletedTasks(myDayTasks);
  }

  Future<int> insertTask({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required Priority priority,
    required Category category,
    required int important,
    int? completed,
  }) async {
    var response = await sqlDb.insert(
      table: "tasks",
      values: {
        SqlDbUtils.columnTitle: title,
        SqlDbUtils.columnStartDate: startDate.toString(),
        SqlDbUtils.columnEndDate: endDate.toString(),
        SqlDbUtils.columnPriority: priority.index,
        SqlDbUtils.columnCategory: category.index,
        SqlDbUtils.columnImportant: important,
        SqlDbUtils.columnCompleted: completed ?? 0,
      },
    );
    getTasks();
    return response;
  }

  Future<int> updateTask({
    required int id,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required Priority priority,
    required Category category,
    required int important,
    required int completed,
  }) async {
    var response = await sqlDb.update(
      table: "tasks",
      values: {
        SqlDbUtils.columnTitle: title,
        SqlDbUtils.columnStartDate: startDate.toString(),
        SqlDbUtils.columnEndDate: endDate.toString(),
        SqlDbUtils.columnPriority: priority.index,
        SqlDbUtils.columnCategory: category.index,
        SqlDbUtils.columnImportant: important,
        SqlDbUtils.columnCompleted: completed,
      },
      mywhere: "${SqlDbUtils.columnId} = $id",
    );
    getTasks();
    return response;
  }

  Future<int> deleteTask({
    required int id,
  }) async {
    var response = await sqlDb.delete(
      table: "tasks",
      mywhere: "${SqlDbUtils.columnId} = $id",
    );
    getTasks();
    return response;
  }

  List<dynamic> filterTasksByCategory(tasks, Category category) {
    if (tasks != []) {
      return tasks.where((task) => task!.category == category).toList();
    } else
      return [];
  }

  List<dynamic> filterTasksByDay(List<dynamic> tasks, DateTime targetDay) {
    return tasks.where((task) {
      // Compare the date of each task with the target day
      return task.startDate.year == targetDay.year &&
          task.startDate.month == targetDay.month &&
          task.startDate.day == targetDay.day;
    }).toList();
  }

  void updateFilteredUpcomingTaskOnDaySelected(
      DateTime selectedDay, DateTime focusedDay) {
    filterDate.value = selectedDay;
    filterTask.value = filterTasksByDay(upcomingTasks, selectedDay);
  }

  List<dynamic> getTasksInCurrentDay(tasks) {
    if (tasks != []) {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      return tasks
          .where((task) =>
              task!.startDate.isAfter(startOfDay) &&
              task.startDate.isBefore(endOfDay))
          .toList();
    } else
      return [];
  }

  List<dynamic> getImportantTasks(tasks) {
    if (tasks != []) {
      return tasks.where((task) => task!.important == 1).toList();
    } else
      return [];
  }

  List<dynamic> filterNotCompletedTasks(List<dynamic> tasks) {
    return tasks.where((task) => task.completed == 0).toList();
  }

  List<dynamic> getUpcomingTasks(tasks) {
    if (tasks != []) {
      final now = DateTime.now();
      return tasks
          .where(
              (task) => (task!.startDate.isAfter(now) && task.completed == 0))
          .toList();
    } else
      return [];
  }
}
