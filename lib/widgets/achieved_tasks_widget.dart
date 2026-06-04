import 'package:flutter/material.dart';
import 'package:planify/constants.dart';
import 'package:planify/models/task_model.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key, required this.task});
  final List<TaskModel> task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff282828),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff6E6E6E),
                    valueColor: AlwaysStoppedAnimation<Color>(kBottomColor),
                    value: task.isEmpty
                        ? 0
                        : task.where((t) => t.isDone).length / task.length,
                    strokeWidth: 4,
                  ),
                ),
                Text(
                  '${task.isEmpty ? 0 : (task.where((t) => t.isDone).length / task.length * 100).toInt()}%',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
