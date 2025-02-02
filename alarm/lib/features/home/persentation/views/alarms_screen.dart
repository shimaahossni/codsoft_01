// features/home/persentation/views/alarms_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:alarm/core/services/app_local_storage.dart';
import 'package:alarm/features/home/data/task_model.dart';

class AlarmsScreen extends StatelessWidget {
  const AlarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Alarms"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: AppLocalStorage.taskBox.listenable(),
        builder: (context, box, _) {
          // Retrieve all tasks from Hive
          List<TaskMdel> tasks = AppLocalStorage.getAllTasks();

          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                "No alarms available.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              TaskMdel task = tasks[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Alarm Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.title ?? "Untitled Alarm",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Delete the task
                              box.delete(task.id);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Time
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            "${task.startTime ?? "Unknown Time"}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Repeat Option
                      Row(
                        children: [
                          const Icon(Icons.repeat, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            task.note ?? "No Repeat",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
