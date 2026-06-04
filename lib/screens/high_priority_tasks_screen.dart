import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planify/models/task_model.dart';
import 'package:planify/widgets/task_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('tasks');
    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);
      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        highPriorityTasks = highPriorityTasks
            .where((element) => element.isHighPriority)
            .toList()
            .reversed
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskListWidget(
          taskMessage: 'No tasks yet.',
          task: highPriorityTasks,
          updateTask: (bool? value, int? index) async {
            setState(() {
              highPriorityTasks[index!].isDone = value ?? false;
            });
            final pref = await SharedPreferences.getInstance();

            final allData = pref.getString('tasks');
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
              final newIndex = allDataList.indexWhere(
                (element) => element.id == highPriorityTasks[index!].id,
              );
              allDataList[newIndex] = highPriorityTasks[index!];
              await pref.setString('tasks', jsonEncode(allDataList));
              _loadTask();
            }
          },
        ),
      ),
    );
  }
}
