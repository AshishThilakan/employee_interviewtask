import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeSingleViewPage extends StatefulWidget {
  final String employeeList;

  EmployeeSingleViewPage({required this.employeeList});

  @override
  State<EmployeeSingleViewPage> createState() => _EmployeeSingleViewPageState();
}

class _EmployeeSingleViewPageState extends State<EmployeeSingleViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Employee Details'),
      ),
      body: FutureBuilder<Employee>(
        future: fetchEmployeeDetails(widget.employeeList),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final employee = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(employee.name),
                ),
                ListTile(
                  title: Text('DOB'),
                  subtitle: Text(employee.dob),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(employee.email),
                ),
                ListTile(
                  title: Text('City'),
                  subtitle: Text(employee.city),
                ),
                ListTile(
                  title: const Text('Gender'),
                  subtitle: Text(employee.gender),
                ),
                ListTile(
                  title: const Text('Address'),
                  subtitle: Text(employee.address),
                ),
                ListTile(
                  title: const Text('Phone'),
                  subtitle: Text(employee.phone),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class Employee {
  final String name;
  final String dob;
  final String email;
  final String city;
  final String gender;
  final String address;
  final String phone;

  Employee({
    required this.name,
    required this.dob,
    required this.email,
    required this.city,
    required this.gender,
    required this.address,
    required this.phone,
  });
}


Future<Employee> fetchEmployeeDetails(String employeeList) async {
  final response = await http.post(
      Uri.parse('https://cashbes.com/attendance/apis/employee_view'),
      body: await Future.delayed(const Duration(seconds: 2)));


  final employee = Employee(
    name: 'dam',
    dob: '12-08-1997',
    email: 'sjdfhj@gmail.com',
    city: 'Kochi',
    gender: 'Male',
    address: 'Church street',
    phone: '9129876543',
  );

  return employee;
}
