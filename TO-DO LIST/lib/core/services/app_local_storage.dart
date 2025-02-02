// core/services/app_local_storage.dart
import 'package:hive/hive.dart';
import 'package:todo/core/model/task_model.dart';

class AppLocalStorage {
  static late Box userBox;
  static late Box<TaskMdel> taskBox;
  static String nameKey = "nameKey";
  static String imageKey = "imageKey";
  static String isUpload = "isUploadKey";

  static init() {
    userBox = Hive.box('user');
    taskBox = Hive.box<TaskMdel>('task');
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
}
