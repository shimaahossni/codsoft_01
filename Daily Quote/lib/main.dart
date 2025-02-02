// main.dart
import 'package:flutter/material.dart';
import 'package:quote_task2/core/services/local_storage/local_storage.dart';
import 'package:quote_task2/features/quote_home/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.init();
  runApp(const QuoteOfTheDayApp());
}

class QuoteOfTheDayApp extends StatelessWidget {
  const QuoteOfTheDayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote of the Day',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
