// feature/home/home_screen.dart
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/core/functions/newNavigation.dart';
import 'package:todo/core/model/task_model.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/utils/text_style.dart';
import 'package:todo/core/widgets/action_appbar.dart';
import 'package:todo/core/widgets/date_addtask_button.dart';
import 'package:todo/core/widgets/task_item.dart';
import 'package:todo/core/widgets/title_appbar.dart';
import 'package:todo/feature/add_task/add_new_task.dart';
import '../../core/utils/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        toolbarHeight: mediaquery.height * .075,
        // backgroundColor: AppColor.whiteColor,
        title: TitleAppBar(),
        actions: [
          ActionAppBar(),
          SizedBox(
            width: mediaquery.width * .02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            /////////////////////////////////////////////////////////////////addtask button
            DateAndAddTaskButton(),

            ////////////////////////////////////////////////////////////////////calender slider
            DatePicker(
              width: mediaquery.width * .185,
              height: mediaquery.height * .13,
              DateTime.now().subtract(Duration(days: 2)),
              initialSelectedDate: DateTime.now(),
              selectionColor: AppColor.purpleColor,
              selectedTextColor: AppColor.whiteColor,
              onDateChange: (date) {
                setState(() {
                  selectedDate = DateFormat('dd/MM/yyyy').format(date);
                });
              },
            ),

            SizedBox(
              height: mediaquery.height * .01,
            ),
            //  Lottie.asset('assets/images/empty.json'),

            ////////////////////////////////////////////////////////////////////listView tasks
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaquery.width * .02),
              child: SizedBox(
                height: mediaquery.height * .65,
                child: ValueListenableBuilder(
                  valueListenable: AppLocalStorage.taskBox.listenable(),
                  builder: (context, box, child) {
                    List<TaskMdel> tasks = [];

                    for (var element in box.values) {
                      if (element.date == selectedDate) {
                        tasks.add(element);
                      }
                    }

                    if (tasks.isEmpty) {
                      return Column(
                        children: [
                          Lottie.asset(
                            'assets/images/empty.json',
                          ),
                          Text(
                            "No tasks for $selectedDate",
                            style: gettitleTextStyle(
                                fontsize: 16, color: AppColor.greyColor),
                          )
                        ],
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          child: GestureDetector(
                            onTap: () {
                              pushTo(
                                  context, AddNewTask(taskmodel: tasks[index]));
                            },
                            child: TaskItem(
                              taskmodel: tasks[index],
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              //complete task
                              box.put(
                                  tasks[index].id,
                                  TaskMdel(
                                      title: tasks[index].title,
                                      note: tasks[index].note,
                                      date: tasks[index].date,
                                      startTime: tasks[index].startTime,
                                      endTime: tasks[index].endTime,
                                      color: 3,
                                      id: tasks[index].id,
                                      isCompleted: true));
                            } else {
                              //delete task
                              box.delete(tasks[index].id);
                            }
                          },
                          secondaryBackground: Container(
                            padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsets.only(bottom: 10, left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.redColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColor.whiteColor,
                                ),
                                Text("Delete  ",
                                    style: gettitleTextStyle(
                                        color: AppColor.whiteColor))
                              ],
                            ),
                          ),
                          background: Container(
                            padding: EdgeInsets.all(10),
                            margin:
                                EdgeInsets.only(bottom: 10, left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: AppColor.whiteColor,
                                ),
                                Text("Complete",
                                    style: gettitleTextStyle(
                                        color: AppColor.whiteColor))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
