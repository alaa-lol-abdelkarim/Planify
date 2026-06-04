import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';
import 'package:planify/screens/high_priority_tasks_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.task,
    required this.updateTask,
    required this.refresh,
  });

  final List<TaskModel> task;
  final Function(bool?, int?) updateTask;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kDarkModeTileColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    'High Priority Tasks',
                    textAlign: TextAlign.center,
                    style: kTextStyle.copyWith(
                      fontSize: 14,
                      color: kBottomColor,
                    ),
                  ),
                ),
                ...task.reversed.where((e) => e.isHighPriority).take(4).map((
                  e,
                ) {
                  return Row(
                    children: [
                      Checkbox(
                        activeColor: kBottomColor,
                        value: e.isDone,
                        onChanged: (bool? value) {
                          final index = task.indexWhere(
                            (element) => element.id == e.id,
                          );
                          updateTask(value, index);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          e.taskName,
                          style: kTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: e.isDone
                                ? Color(0xFFA0A0A0)
                                : Color(0xffffffff),
                            decoration: e.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: Color(0xFFA0A0A0),
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityTasksScreen();
                  },
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kDarkModeTileColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: kDarkModeBorderColor),
                ),
                child: Icon(Icons.arrow_forward, color: Color(0xffC6C6C6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
