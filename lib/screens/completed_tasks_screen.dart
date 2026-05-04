import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planify/models/task_model.dart';
import 'package:planify/widgets/task_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
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
        task = task.where((element) => element.isDone == true).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskListWidget(
          taskMessage: 'No tasks completed yet.',
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
