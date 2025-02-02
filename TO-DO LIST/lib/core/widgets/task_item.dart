// core/widgets/task_item.dart
import 'package:flutter/material.dart';
import 'package:todo/core/model/task_model.dart';
import 'package:todo/core/utils/color.dart';
import 'package:todo/core/utils/text_style.dart';

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
                ? AppColor.purpleColor
                : taskmodel.color == 1
                    ? AppColor.orangeColor
                    : AppColor.redColor,
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
                  style: gettitleTextStyle(
                    color: AppColor.whiteColor,
                    fontsize: mediaquery.width * .04,
                  ),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: mediaquery.width * .02,
                    ),
                    Text(
                      "${taskmodel.startTime} : ${taskmodel.endTime}",
                      style: gettitleTextStyle(
                        color: AppColor.whiteColor,
                        fontsize: mediaquery.width * .035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                Text(
                  taskmodel.note ?? "",
                  style: gettitleTextStyle(
                      color: AppColor.whiteColor,
                      fontsize: mediaquery.width * .045,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: mediaquery.height * .1,
            color: AppColor.greyColor,
          ),
          SizedBox(
            width: mediaquery.width * .02,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              (taskmodel.isCompleted ?? false) ? "COMPLETE" : "TODO",
              style: gettitleTextStyle(
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
