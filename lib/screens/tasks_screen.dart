import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planify/models/task_model.dart';
import 'package:planify/widgets/task_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> task = [];

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
        task = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        task = task.where((element) => element.isDone == false).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskListWidget(
          taskMessage: 'No tasks yet.',
          task: task,
          updateTask: (bool? value, int? index) async {
            setState(() {
              task[index!].isDone = value ?? false;
            });
            final pref = await SharedPreferences.getInstance();
            final updatedTask = task
                .map((element) => element.toJson())
                .toList();
            await pref.setString('tasks', jsonEncode(updatedTask));
            _loadTask();
          },
        ),
      ),
    );
  }
}
