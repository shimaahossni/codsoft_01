// main.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/core/model/task_model.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/theme_application/theme.dart';
import 'feature/intro/splash_screen.dart';

//add hive and hive_flutter to pubspec.yaml
//initialize hive
//open a box with tha same name of ur choice"user"
//generate type adapter for ur model "type adapter to generate object to store in db and retrieve from db"

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive db
  await Hive.initFlutter();
  //create or open a box(table name)...
  await Hive.openBox('user');
  //type adapter generator
  Hive.registerAdapter(TaskMdelAdapter());
  //create box for task table
  await Hive.openBox<TaskMdel>("task");
  //initialize app
  await AppLocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App Demo',
      //themeMode: ThemeMode.dark ,

      theme: DateTime.now().hour >= 18 || DateTime.now().hour < 6
          ? ApplicationThemeManager.darkTheme
          : ApplicationThemeManager.lightTheme,
      home: SplashScreen(),
    );
  }
}
