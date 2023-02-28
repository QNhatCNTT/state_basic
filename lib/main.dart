import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_basic/pages/apptodo.dart';
import 'package:state_basic/provider/task_provider.dart';

import 'database/tasks_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TaskDB? database;
  // ignore: dead_code
  await database?.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksProvider>(
      create: (_) => TasksProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: const SafeArea(child: TodoList()),
      ),
    );
  }
}