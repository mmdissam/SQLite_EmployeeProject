import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqlliteproject/models/employee.dart';
import 'package:sqlliteproject/utils/database_helper.dart';
import 'package:sqlliteproject/views/employee_screen.dart';

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
    databaseHelper.getAllEmployee().then((employees) {
      setState(() {
        employees.forEach((employee) {
          items.add(Employee.map(employee));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: items.length,
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(
                  height: 15,
                ),
                _allInfo(position),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => _addNewEmployee(context),
      ),
    );
  }

  Widget _allInfo(int position) {
    return ListTile(
      title: Text(
        '${items[position].name}',
        style: TextStyle(color: Colors.blue),
      ),
      subtitle: Text(
        '${items[position].age} - ${items[position].city} - ${items[position].department} - ${items[position].description}',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      leading: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          CircleAvatar(
            backgroundColor: Colors.tealAccent,
            radius: 18,
            child: Text(
              '${items[position].id}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade900,
              ),
              onPressed: () =>
                  _deleteEmployee(context, items[position], position)),
        ],
      ),
      onTap: () => _navigateToEmployee(context, items[position]),
    );
  }

  void _deleteEmployee(
      BuildContext context, Employee employee, int position) async {
    databaseHelper.deleteEmployee(employee.id).then((employees) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToEmployee(BuildContext context, Employee employee) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeScreen(employee),
      ),
    );
//   To delete old values and show new ones
    if (result == 'update') {
      databaseHelper.getAllEmployee().then((employees) {
        setState(() {
          items.clear();
          employees.forEach((employee) {
            items.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }

  void _addNewEmployee(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EmployeeScreen(Employee( 1,2 , '', '', '', ''))));
    if (result == 'save') {
      //To refresh data on screen
      databaseHelper.getAllEmployee().then((employees) {
        setState(() {
          items.clear();
          employees.forEach((employee) {
            items.add(Employee.fromMap(employee));
          });
        });
      });
    }
  }
}
