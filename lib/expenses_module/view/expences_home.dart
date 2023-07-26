// Floating action buttomn
// chat Ui
// add expense screen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/controller/expense_controller.dart';
import 'package:test_project/routes/app_routes.dart';

class HomeScreen extends GetView<ExpenseController> {
  final categoryId;
   HomeScreen({
    this.categoryId,
       Key? key}) : super(key: key);


  Future<List<ExpenseTableData>> getExpenseList() async {
    return await controller.database!.getAllData();
  }

  getDatabase() {
    return controller.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addExpenseScreen);
        },
      ),
      body: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Add Expenses",
                style: TextStyle(
                fontSize: 16,
              ),)
            ],
          )),
    );
  }

}
