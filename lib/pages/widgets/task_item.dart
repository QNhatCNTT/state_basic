import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String nameTask;
  final String descriptionTask;
  final String dateTimeTask;
  final String statusTask;
  final Widget icon;
  const TaskItem(
      {Key? key,
      this.nameTask = '',
      this.descriptionTask = '',
      this.dateTimeTask = '',
      this.statusTask = '',
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.deepPurple[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    nameTask,
                    maxLines: null,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                  Text(
                    descriptionTask,
                    maxLines: null,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                        fontSize: 18),
                  ),
                  // const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                  Text(
                    dateTimeTask,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                  Text(
                    statusTask,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                        fontSize: 14),
                  )
                ],
              ),
            ),
            icon
          ],
        ),
      ),
    );
  }
}
