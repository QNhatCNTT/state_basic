// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:state_basic/database/tasks_db.dart';

import 'package:state_basic/models/task.dart';

import '../provider/task_provider.dart';
import 'widgets/add_task.dart';
import 'widgets/task_item.dart';
import 'notfound.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  TextEditingController searchController = TextEditingController();
  late String keyword;

  @override
  void initState() {
    searchController.addListener(
      () {
        setState(() {
          keyword = searchController.text;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: AppBar(
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.navigate_before, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Container(
                padding: const EdgeInsets.only(left: 2),
                child: const Text('All Tasks',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              flexibleSpace: Container(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.black.withAlpha(200),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: "Search Tasks",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(200),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (String keyword) {
                                Provider.of<TasksProvider>(context,
                                        listen: false)
                                    .changeSearch(keyword);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Consumer<TasksProvider>(
          builder: (context, TasksProvider data, child) {
            return data.getTasks.isNotEmpty
                ? ListView.builder(
                    itemCount: data.getTasks.length,
                    itemBuilder: (context, index) {
                      return TaskList(data.getTasks[index], index);
                    })
                : const NotFound();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddTask(),
                  fullscreenDialog: true,
                ));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final Task task;
  final int index;
  const TaskList(this.task, this.index, {super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    widget.task.status = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var date =
        DateFormat('d MMM, y - hh:mm aaa').format(widget.task.createdTime);
    if (widget.task.createdTime
            .difference(DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, DateTime.now().hour, DateTime.now().minute))
            .inMinutes <=
        0) {
      setState(() {
        widget.task.status = true;
      });
    }
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TaskItem(
          nameTask: widget.task.name,
          descriptionTask: widget.task.description,
          dateTimeTask: date.toString(),
          statusTask: widget.task.status ? 'completed' : '',
          icon: IconButton(
            onPressed: () {
              Provider.of<TasksProvider>(context, listen: false)
                  .removeTasks(widget.task);
              var taskDB = TaskDB();
              taskDB.delete(widget.index.toString());
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ));
  }
}
