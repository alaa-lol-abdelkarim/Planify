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
  List<TaskModel> todoTasks = [];

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
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        todoTasks = todoTasks
            .where((element) => element.isDone == false)
            .toList();
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
          task: todoTasks,
          updateTask: (bool? value, int? index) async {
            setState(() {
              todoTasks[index!].isDone = value ?? false;
            });
            final pref = await SharedPreferences.getInstance();

            final allData = pref.getString('tasks');
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
              final newIndex = allDataList.indexWhere(
                (element) => element.id == todoTasks[index!].id,
              );
              allDataList[newIndex] = todoTasks[index!];
              await pref.setString('tasks', jsonEncode(allDataList));
              _loadTask();
            }
          },
        ),
      ),
    );
  }
}
