import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../provider/task_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime? dateTime = DateTime.now();
  Future _selectedDateTime(BuildContext context) async {
    final date = await _selectedDate(context);
    if (date == null) return;
    final time = await _selectedTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> _selectedDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(initialDate.year + 2),
        helpText: 'Selected Date and Time');

    if (_datePicker == null) return null;
    return _datePicker;
  }

  Future<TimeOfDay?> _selectedTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final TimeOfDay? _timePicker = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (_timePicker == null) return null;
    return _timePicker;
  }

  String? getText() {
    return DateFormat('d MMM, y - h:mm a').format(dateTime!);
  }

  final _nameController = TextEditingController();
  final _desController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _desController.dispose();
    super.dispose();
  }

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    var _text = '';
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: Colors.white)),
            title: const Text("Add New Task"),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  setState(() {
                    if (_nameController.text.isEmpty) {
                      _validate = true;
                    } else {
                      _validate = false;
                      final task = Task(
                        name: _nameController.text,
                        createdTime: dateTime!,
                        description: _desController.text,
                      );
                      Provider.of<TasksProvider>(context, listen: false)
                          .addTasks(task);

                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ListView(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _nameController,
                      autofocus: true,
                      onChanged: (text) => setState(() => _text),
                      maxLines: 1,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'Task name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        errorText:
                            _validate ? 'Can\'t be empty task name' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _desController,
                      onChanged: (text) => setState(() => _text),
                      maxLines: null,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade50,
                              elevation: 0,
                              alignment: Alignment.centerLeft,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedDateTime(context);
                              });
                            },
                            child: Text(getText()!,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }
}