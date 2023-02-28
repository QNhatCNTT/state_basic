import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_basic/database/tasks_db.dart';
import 'package:state_basic/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  TaskDB dao = TaskDB();
  String _keyword = '';

  Future<void> loadTasks() async {
    _tasks = await dao.getTasks();
    notifyListeners();
  }

  List<Task> get getTasks {
    if (_keyword.isEmpty) {
      return _tasks;
    } else {
      return _tasks
          .where((task) =>
              task.name.toLowerCase().contains(_keyword.toLowerCase()))
          .toList();
    }
  }

  void changeSearch(String keyword) {
    if(keyword.isNotEmpty){
    _keyword = keyword;
    notifyListeners();
    }
  }

  final date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<Task> get getTodayTasks => _tasks
      .where((task) =>
          DateFormat('d MMM, y').format(task.createdTime) ==
          DateFormat('d MMM, y').format(date))
      .toList();

  List<Task> get getUpcomingTasks => _tasks
      .where((task) => task.createdTime.difference(date).inDays > 0)
      .toList();

  Future<void> addTasks(Task task) async {
    _tasks.insert(0, task);
    var taskDB = TaskDB();
    int id = await taskDB.insert(task);
    int minutes = -10;
    DateTime dateSchedule = task.createdTime.add(Duration(minutes: minutes));
    notifyListeners();
  }

  Future<void> removeTasks(Task task) async {
    _tasks.remove(task);
    notifyListeners();
  }
}
