import 'package:flutter/material.dart';
import 'package:state_basic/pages/widgets/task_ui.dart';
import 'package:state_basic/pages/today.dart';
import 'package:state_basic/pages/upcoming.dart';
import 'all_tasks_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 50, top: 10, right: 50),
      children: [
        const SizedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Center(
              child: Text('Tasks Management',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
            ),
          ),
        ),
        TaskWidget(
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllTasksPage()));
            },
            text: 'All Tasks',
            imageURL: 'assets/images/schedule.png'),
        TaskWidget(
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TodayPage()));
            },
            text: 'Today',
            imageURL: 'assets/images/calendar.png'),
        TaskWidget(
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpcomingPage()));
            },
            text: 'Upcoming',
            imageURL: 'assets/images/next-week.png'),
      ],
    );
  }
}
