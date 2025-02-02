// features/home/persentation/widget/task_model.dart
import 'package:alarm/features/home/data/task_model.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskmodel});

  final TaskMdel taskmodel;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: mediaquery.height * .01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: taskmodel.color == 3
            ? Colors.green
            : taskmodel.color == 0
                ? Colors.purple
                : taskmodel.color == 1
                    ? Colors.orange
                    : Colors.red,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskmodel.title ?? " ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black)
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: mediaquery.width * .02,
                    ),
                    Text(
                      "${taskmodel.startTime} : ${taskmodel.endTime}",
                      style: TextStyle(
                        color: Colors.green
                      )
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Text(
                  taskmodel.note ?? "",
                  style:TextStyle(color: Colors.white),),
              ],
            ),
          ),
          Container(
            width: 1,
            height: mediaquery.height * .1,
            color: Colors.grey,
          ),
          SizedBox(
            width: mediaquery.width * .02,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              (taskmodel.isCompleted ?? false) ? "COMPLETE" : "TODO",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
