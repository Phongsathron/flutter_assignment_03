import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignment_03/views/AddTaskScreen.dart';
import 'package:flutter_assignment_03/views/TaskScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TaskScreen(),
        '/add': (context) => AddTaskScreen()
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}