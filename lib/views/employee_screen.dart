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
  void initState() {
    _ageController = TextEditingController(text: '${widget.employee.age}');
    _nameController = TextEditingController(text: widget.employee.name);
    _departmentController =
        TextEditingController(text: widget.employee.department);
    _cityController = TextEditingController(text: widget.employee.city);
    _descriptionController =
        TextEditingController(text: widget.employee.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EmployeeDB'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _name(),
            SizedBox(height: 15),
            _age(),
            SizedBox(height: 15),
            _department(),
            SizedBox(height: 15),
            _city(),
            SizedBox(height: 15),
            _description(),
            SizedBox(height: 15),
            _updateOrAdd(),
          ],
        ),
      ),
    );
  }

  Widget _name() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Name',
      ),
    );
  }

  Widget _age() {
    return TextField(
      controller: _ageController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Age',
      ),
    );
  }

  Widget _department() {
    return TextField(
      controller: _departmentController,
      decoration: InputDecoration(
        labelText: 'Department',
      ),
    );
  }

  Widget _city() {
    return TextField(
      controller: _cityController,
      decoration: InputDecoration(
        labelText: 'City',
      ),
    );
  }

  Widget _description() {
    return TextField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
    );
  }

  Widget _updateOrAdd() {
    return RaisedButton(
      onPressed: () {
        if (widget.employee.id != null) {
          _onPressedUpdate();
        } else {
          _onPressedAdd();
        }
      },
      child: (widget.employee.id != null) ? Text('Update') : Text('Add'),
    );
  }

  void _onPressedUpdate() {
    if (widget.employee.id != null) {
      databaseHelper
          .updateEmployee(Employee.fromMap({
        'id': widget.employee.id,
        'age': widget.employee.age,
        'name': widget.employee.name,
        'department': widget.employee.department,
        'city': widget.employee.city,
        'description': widget.employee.description,
      }))
          .then((_) {
        Navigator.pop(context, 'Update');
      });
    }
  }

  void _onPressedAdd() {
    databaseHelper
        .insertEmployee(
      Employee(
          _ageController.text,
          _nameController.text,
          _departmentController.text,
          _cityController.text,
          _descriptionController.text),
    )
        .then((_) {
      Navigator.pop(context, 'Add');
    });
  }
}
