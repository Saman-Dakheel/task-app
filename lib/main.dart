import 'package:flutter/material.dart';
import 'package:task_app/view/add_task.dart';
import 'package:task_app/view/detail_screen.dart';
import 'package:task_app/view/edit_task.dart';
import 'package:task_app/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(elevation: 2.0, color: Colors.green),
        brightness: Brightness.dark,
      ),
      initialRoute: Home.home,
      routes: {
        Home.home: (context) => Home(),
        AddTask.addTask: (context) => AddTask(),
        EditTask.editTask: (context) => EditTask(),
        DetailScreen.detailScreen: (context) => const DetailScreen(),
      },
    );
  }
}
