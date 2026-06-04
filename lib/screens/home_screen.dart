import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';
import 'package:planify/widgets/high_priority_tasks_widget.dart';
import 'package:planify/widgets/task_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_task_screen.dart';
import 'package:planify/widgets/achieved_tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = 'Default';
  List<TaskModel> task = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadTask();
  }

  void _loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username') ?? 'User';
    });
  }

  void _loadTask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('tasks');
    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);
      setState(() {
        task = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
      });
    }
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      task[index!].isDone = value ?? false;
    });
    final pref = await SharedPreferences.getInstance();
    final updatedTask = task.map((element) => element.toJson()).toList();
    await pref.setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 48,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, AddTask.id);
            if (result != null && result == true) {
              _loadTask();
            }
          },
          backgroundColor: kBottomColor,
          foregroundColor: Colors.white,
          icon: Icon(Icons.add),
          label: Text('Add New Task'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: SvgPicture.asset('assets/images/avatar.svg'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Evening, $username', style: kTextStyle),
                        Text(
                          'One task at a time. One step closer.',
                          style: kTextStyle.copyWith(
                            fontSize: 14,
                            color: Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.wb_sunny_outlined, color: Colors.white),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Yuhuu, Your work Is',
                style: kTextStyle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'almost done!',
                    style: kTextStyle.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/images/waving_hand.svg', height: 28),
                ],
              ),
              SizedBox(height: 24),
              AchievedTasksWidget(task: task),
              SizedBox(height: 8),
              HighPriorityTasksWidget(
                task: task,
                updateTask: (bool? value, int? index) {
                  _doneTask(value, index);
                },
                refresh: _loadTask,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 24.0, bottom: 16.0),
                child: Text('Tasks', style: kTextStyle.copyWith(fontSize: 20)),
              ),
              Expanded(
                child: TaskListWidget(
                  task: task,
                  updateTask: (bool? value, int? index) {
                    _doneTask(value, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
