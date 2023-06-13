import 'package:flutter/material.dart';
import '../api_models/get_model_details.dart';
import '../api_services_class/api_services.dart';
import 'employee_singleview.dart';
import 'get_addemployee.dart';

class GetEmployeeDetailsScreen extends StatefulWidget {
  const GetEmployeeDetailsScreen({super.key});

  @override
  State<GetEmployeeDetailsScreen> createState() =>
      _GetEmployeeDetailsScreenState();
}

class _GetEmployeeDetailsScreenState extends State<GetEmployeeDetailsScreen> {
  List<GetMethodModel> employeeList = [];
  bool isLoading = true;

  @override
  void initState() {
    getEmpolyeeData();
    super.initState();
  }

  getEmpolyeeData() async {
    employeeList = await ApiServices().fetchEmployees();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: const Text('Employee details'),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEmployeeScreen(),
              ));
        },
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Add employee',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? const SingleChildScrollView(
              child: Center(
                  child: CircularProgressIndicator()))
          : ListView.builder(
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(employeeList[index].id.toString()),
                  title: Text(employeeList[index].name.toString()),
                  subtitle: Text(employeeList[index].email.toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeSingleViewPage(employeeList: '',),
                          settings:
                              RouteSettings(arguments: employeeList[index]),
                        ));
                  },
                );
              },
            ),
    );
  }
}
