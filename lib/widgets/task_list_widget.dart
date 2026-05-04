import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    this.taskMessage,
    required this.task,
    required this.updateTask,
  });

  final String? taskMessage;
  final List<TaskModel> task;
  final Function(bool?, int?) updateTask;

  @override
  Widget build(BuildContext context) {
    return task.isEmpty
        ? Center(
            child: Text(
              taskMessage ?? 'No tasks yet. Tap + to add one!',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 55.0),
            itemCount: task.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff282828),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: kBottomColor,
                          value: task[index].isDone,
                          onChanged: (bool? value) {
                            updateTask(value, index);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  decorationColor: Color(0xFFA0A0A0),
                                ),
                              ),
                              Text(
                                task[index].taskDescription,
                                style: kTextStyle.copyWith(
                                  fontSize: 14,
                                  color: Color(0xffC6C6C6),
                                  decoration: task[index].isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  decorationColor: Color(0xFFA0A0A0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert, color: Color(0xffC6C6C6)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
