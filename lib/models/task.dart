import 'package:intl/intl.dart';

class Task {
  int id;
  String name;
  String description;
  DateTime createdTime;
  bool status;

  Task({
    required this.name,
    required this.createdTime,
    this.description = '',
    this.status = false,
    this.id = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createdTime': DateFormat('d MMM, y - h:mm a').format(createdTime),
      'status': status ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id:  map['id'],
      name: map['name'],
      description: map['description'],
      status: map['status'] == 1 ? true : false,
      createdTime: DateFormat('d MMM, y - h:mm a')
                .parse(map['createdTime'])
    );
  }
}
