import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqlliteproject/models/employee.dart';
import 'package:sqlliteproject/utils/database_helper.dart';

class ListViewEmployee extends StatefulWidget {
  @override
  _ListViewEmployeeState createState() => _ListViewEmployeeState();
}

class _ListViewEmployeeState extends State<ListViewEmployee> {

  List<Employee> items = List();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    //To get all Employee at first run app
    databaseHelper.getAllEmployee().then((employees){
      setState(() {
        employees.forEach((employee){
          items.add(Employee.map(employee));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
