// core/widgets/date_addtask_button.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/functions/newNavigation.dart';
import 'package:todo/core/utils/color.dart';
import 'package:todo/feature/add_task/add_new_task.dart';

class DateAndAddTaskButton extends StatefulWidget {
  const DateAndAddTaskButton({super.key});

  @override
  State<DateAndAddTaskButton> createState() => _DateAndAddTaskButtonState();
}

class _DateAndAddTaskButtonState extends State<DateAndAddTaskButton> {
  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    DateTime focusDate = DateTime.now();
    String date = DateFormat.yMMMMd().format(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: mediaquery.width * .06,
                  fontWeight: FontWeight.bold),
            ),
            Text(
                (DateFormat.E().format(focusDate)) ==
                        (DateFormat.E().format(focusDate))
                    ? "Today"
                    : DateFormat.E().format(focusDate),
                style: TextStyle(
                    color: ThemeMode.light == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    fontSize: mediaquery.width * .06,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          width: mediaquery.width * .1,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: AppColor.purpleColor,
              foregroundColor: AppColor.whiteColor,
            ),
            onPressed: () {
              pushTo(context, AddNewTask());
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Task")),
      ],
    );
  }
}
