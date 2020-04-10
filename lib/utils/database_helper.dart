/*To connect database with my application, we use this util*/
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqlliteproject/models/employee.dart';

class DatabaseHelper {
  final String tableEmployee = 'employeeTable';
  final String columnId = 'id';
  final String columnAge = 'age';
  final String columnName = 'name';
  final String columnDepartment = 'department';
  final String columnCity = 'city';
  final String columnDescription = 'description';

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    return await openDB();
  }

  openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'employees.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int newVersion) async {
    var sql =
        "CREATE TABLE $tableEmployee ($columnId INTEGER PRIMARY KEY, $columnAge TEXT,$columnName TEXT,$columnCity TEXT,$columnDepartment TEXT, $columnDescription TEXT)";
    await db.execute(sql);
  }

  Future<int> insertEmployee(Employee employee) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableEmployee, employee.toMap());
    return result;
  }

  Future<List> getAllEmployee() async {
    var dbClient = await db;
    var result = await dbClient.query(tableEmployee, columns: [
      columnId,
      columnAge,
      columnName,
      columnDepartment,
      columnCity,
      columnDescription,
    ]);
    return result.toList();
  }

  Future<int> getNumOfEmployees() async {
    var dbClient = await db;
    String sql = 'SELECT COUNT(*) FROM $tableEmployee';
    return Sqflite.firstIntValue(await dbClient.rawQuery(sql));
  }

  Future<Employee> getEmployee(int id) async {
    var dbClient = await db;
    /*var sql = "SELECT * FROM $tableEmployee WHERE $columnId = $id";
    List result = await dbClient.rawQuery(sql);*/
    List<Map> result1 = await dbClient.query(tableEmployee,
        columns: [
          columnId,
          columnAge,
          columnName,
          columnDepartment,
          columnCity,
          columnDescription,
        ],
        where: '$columnId = ?',
        whereArgs: ['id']);
//   If user not found
    if (result1.length == 0) {
      return null;
    }
//  result.first TO arrange the values
    return new Employee.fromMap(result1.first);
  }

  Future<int> updateEmployee(Employee employee) async {
    var dbClient = await db;
    return await dbClient.update(
      tableEmployee,
      employee.toMap(),
      where: '$columnId = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableEmployee,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future closeDB() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}
