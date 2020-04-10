import 'package:flutter/material.dart';
import 'package:sqlliteproject/views/listview_employees.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Employees DB",
      home: ListViewEmployee(),
    ),
  );
}
