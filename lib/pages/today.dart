// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../provider/task_provider.dart';
import 'widgets/task_item.dart';
import 'notfound.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.navigate_before, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Today Tasks',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Consumer<TasksProvider>(
          builder: (context, TasksProvider data, child) {
            return data.getTodayTasks.isNotEmpty
                ? ListView.builder(
                    itemCount: data.getTodayTasks.length,
                    itemBuilder: (context, index) {
                      return TaskListToday(data.getTodayTasks[index], index);
                    })
                : const NotFound();
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskListToday extends StatelessWidget {
  Task task;
  int index;
  TaskListToday(this.task, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('d MMM, y - hh:mm aaa').format(task.createdTime);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TaskItem(
          nameTask: task.name,
          descriptionTask: task.description,
          dateTimeTask: date.toString(),
          statusTask: task.status ? 'completed' : '',
          icon: IconButton(
            onPressed: () {
              Provider.of<TasksProvider>(context, listen: false)
                  .removeTasks(task);
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ));
  }
}
