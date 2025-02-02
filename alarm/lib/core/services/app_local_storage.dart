// core/services/app_local_storage.dart
import 'package:alarm/features/home/data/task_model.dart';
import 'package:hive/hive.dart';

class AppLocalStorage {
  static late Box userBox;
  static late Box<TaskMdel> taskBox;
  static late Box alarms;
  static String repeat = "repeatKey";
  static String label = "labelKey";
  static bool isSnooze = false;
  static String sound = "soundKey";
  static int color = 0;

  static init() {
    userBox = Hive.box('user');
    taskBox = Hive.box<TaskMdel>('task');
    alarms = Hive.box('alarms');
  }

//////////////////////////////////////////////////////////////////////user box functions
  static cachedData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getCachedData(String key) {
    return userBox.get(key);
  }

  //////////////////////////////////////////////////////////////////////task box functions
  static cachedTaskData(String key, TaskMdel value) {
    taskBox.put(key, value);
  }

  static TaskMdel? getCachedTaskData(String key) {
    return taskBox.get(key);
  }

  static List<TaskMdel> getAllTasks() {
    return taskBox.values.toList().cast<TaskMdel>();
  }
}
