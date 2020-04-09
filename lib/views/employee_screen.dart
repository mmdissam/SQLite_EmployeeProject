import 'package:flutter/material.dart';
import 'package:sqlliteproject/models/employee.dart';
import 'package:sqlliteproject/utils/database_helper.dart';

class EmployeeScreen extends StatefulWidget {
  // because this class insert data as a employee
  final Employee employee;
  // And it's transfer data from screen to another by this constructor.
  EmployeeScreen(this.employee);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
