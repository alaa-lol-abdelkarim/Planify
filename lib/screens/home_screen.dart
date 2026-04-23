import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_task_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkModeScreenColor,
      floatingActionButton: SizedBox(
        height: 48,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.pushNamed(context, AddTask.id);
            _loadTask();
          },
          backgroundColor: kBottomColor,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Add New Task'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: SvgPicture.asset('assets/images/avatar.svg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Evening, $username', style: kTextStyle),
                        Text(
                          'One task at a time. One step closer.',
                          style: kTextStyle.copyWith(
                            fontSize: 14,
                            color: const Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.wb_sunny_outlined, color: Colors.white),
                ],
              ),
              const SizedBox(height: 24),
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
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/waving_hand.svg', height: 28),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                color: const Color(0xff282828),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Achieved Tasks', style: kTextStyle),
                          Text(
                            '${task.where((t) => t.isDone).length} Out of ${task.length} Done',
                            style: kTextStyle.copyWith(
                              fontSize: 14,
                              color: const Color(0xffC6C6C6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 24.0, bottom: 16.0),
                child: Text('Tasks', style: kTextStyle.copyWith(fontSize: 20)),
              ),
              Expanded(
                child: task.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks yet. Tap + to add one!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 55.0),
                        itemCount: task.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff282828),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: kBottomColor,
                                      value: task[index].isDone,
                                      onChanged: (bool? value) async {
                                        setState(() {
                                          task[index].isDone = value ?? false;
                                        });
                                        // Save changes to SharedPreferences
                                        final pref =
                                            await SharedPreferences.getInstance();
                                        final updatedTask = task
                                            .map((element) => element.toJson())
                                            .toList();
                                        await pref.setString(
                                          'tasks',
                                          jsonEncode(updatedTask),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task[index].taskName,
                                            style: kTextStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: task[index].isDone
                                                  ? Color(0xFFA0A0A0)
                                                  : Color(0xffffffff),
                                              decoration: task[index].isDone
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              decorationColor: Color(
                                                0xFFA0A0A0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            task[index].taskDescription,
                                            style: kTextStyle.copyWith(
                                              fontSize: 14,
                                              color: const Color(0xffC6C6C6),
                                              decoration: task[index].isDone
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              decorationColor: Color(
                                                0xFFA0A0A0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Color(0xffC6C6C6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
