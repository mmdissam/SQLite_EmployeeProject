import 'package:flutter/material.dart';
import 'package:sqlliteproject/models/employee.dart';
import 'package:sqlliteproject/utils/database_helper.dart';
import 'package:sqlliteproject/views/employee_info.dart';
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
          padding: EdgeInsets.all(5),
          itemCount: items.length,
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                _allInfo(position),
                Divider(height: 15),
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
      trailing: _trailing(position),
      title: _title(position),
      subtitle: _subTitle(position),
      leading: _leading(position),
      onTap: () => _navigateToEmployee(context, items[position]),
      onLongPress: () => _navigateToEmployeeInfo(context, items[position]),
    );
  }

  Widget _title(int position) {
    return Text(
      '${items[position].name}',
      style: TextStyle(color: Colors.blue),
    );
  }

  Widget _subTitle(int position) {
    return Text(
      '${items[position].age} - ${items[position].city} - ${items[position].department} - ${items[position].description}',
      style: TextStyle(fontStyle: FontStyle.italic),
    );
  }

  Widget _leading(int position) {
    return CircleAvatar(
      backgroundColor: Colors.tealAccent,
      child: Text(
        '${items[position].id}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _trailing(int position) {
    return IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red.shade900,
        ),
        onPressed: () => _deleteEmployee(context, items[position], position));
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
  void _navigateToEmployeeInfo(BuildContext context, Employee employee) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeInfo(employee),
      ),
    );
  }

  void _addNewEmployee(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EmployeeScreen(Employee('', '', '', '', ''))));
    if (result == 'Add') {
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
