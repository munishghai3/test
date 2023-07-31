// Floating action buttomn
// chat Ui
// add expense screen

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/controller/expense_home_controller.dart';
import 'package:test_project/routes/app_routes.dart';

class HomeScreen extends GetView<ExpenseHomeController> {
  final categoryId;
  HomeScreen({this.categoryId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "My Expenses",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ).paddingSymmetric(vertical: 30),
                  _chart(),
                  _list()
                ],
              ),
            );
          }),
    );
  }


  _chart() => GetBuilder<ExpenseHomeController>(
    builder: (context) {
      return Container(
        height: 400,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: PieChart(
          PieChartData(
            sections: controller.chartSections(controller.chartData)
          ),
          swapAnimationDuration: Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        )
      );
    }
  );



  _list() => Expanded(
        child: FutureBuilder<List<ExpenseTableData>>(
            future: controller.oldExpenses(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return ListView.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(snapShot.data![index].title).paddingSymmetric(horizontal: 20);
                    });
              }
              return SizedBox(
                  height: 30,
                  width: 30,
                  child: const CircularProgressIndicator());
            }),
      );

  _floatingActionButton() => FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.addExpenseScreen);
        },
      );
}
