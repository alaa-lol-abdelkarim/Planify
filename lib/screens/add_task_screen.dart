import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  static const String id = 'add_task_screen';

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isHighPriority = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // TODO: Dispose this controller
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkModeScreenColor,
      appBar: AppBar(title: Text('Add Task')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task Name', style: kTextStyle),
                SizedBox(height: 8),
                TextFormField(
                  controller: taskNameController,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter task name.';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'e.g Do Homework',
                  ),
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 20),
                Text('Task Description', style: kTextStyle),
                SizedBox(height: 8),
                TextFormField(
                  maxLines: 6,
                  controller: taskDescriptionController,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'e.g Doing Homework Details',
                  ),
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('High Priority', style: kTextStyle),
                    Switch.adaptive(
                      value: isHighPriority,
                      activeTrackColor: kBottomColor,
                      onChanged: (bool value) {
                        setState(() {
                          isHighPriority = value;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBottomColor,
                      foregroundColor: Color(0xFFFFFCFC),
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Add Task'),
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        TaskModel model = TaskModel(
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );

                        final pref = await SharedPreferences.getInstance();
                        final taskJason = pref.getString('tasks');
                        List<dynamic> listOfTasks = [];
                        if (taskJason != null) {
                          listOfTasks = jsonDecode(taskJason);
                        }
                        listOfTasks.add(model.toJson());
                        final taskEncode = jsonEncode(listOfTasks);
                        await pref.setString('tasks', taskEncode);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
