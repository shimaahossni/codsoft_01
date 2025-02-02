// main.dart
import 'package:alarm/core/services/app_local_storage.dart';
import 'package:alarm/features/home/data/task_model.dart';
import 'package:alarm/features/home/persentation/views/home_screen.dart';
import 'package:alarm/features/home/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive db
  await Hive.initFlutter();
  //type adapter generator
  Hive.registerAdapter(TaskMdelAdapter());
  //create box for task table
  await Hive.openBox<TaskMdel>("task");
  await Hive.openBox("user");
  await Hive.openBox("alarms");
  //initialize app
  await AppLocalStorage.init();

  runApp(const AlarmClockApp());
}

class AlarmClockApp extends StatelessWidget {
  const AlarmClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Clock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
