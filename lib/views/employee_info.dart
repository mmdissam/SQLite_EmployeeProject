import 'package:flutter/material.dart';
import 'package:sqlliteproject/utils/database_helper.dart';
import 'package:sqlliteproject/models/employee.dart';

class EmployeeInfo extends StatefulWidget {
  final Employee employee;
  EmployeeInfo(this.employee);
  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String _age = '';
  String _name = '';
  String _department = '';
  String _city = '';
  String _description = '';

  @override
  void initState() {
    super.initState();
    _age = widget.employee.age;
    _name = widget.employee.name;
    _department = widget.employee.department;
    _city = widget.employee.city;
    _description = widget.employee.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('EmployeeDB'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('Name: $_name'),
                SizedBox(height: 15),
                Text('Age: $_age'),
                SizedBox(height: 15),
                Text('Department: $_department'),
                SizedBox(height: 15),
                Text('City: $_city'),
                SizedBox(height: 15),
                Text('Description: $_description'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
