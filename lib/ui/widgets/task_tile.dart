import 'package:flutter/material.dart';
import 'package:to_do/ui/theme.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).orientation == Orientation.landscape
            ? 4
            : 20,
      ),
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: (12),
      ),
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _getBGClr(task.color)),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey[200],
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${task.startTime} - ${task.endTime}',
                              style: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          task.note!,
                          style: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 15,
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 60,
                width: .5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted == 0 ? 'TODO' : 'Completed',
                  style: const TextStyle(
                    color: white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
