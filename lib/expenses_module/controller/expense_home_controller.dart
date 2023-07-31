import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test_project/database/drift_database.dart';

class ExpenseHomeController extends GetxController {
  int touchedIndex = -1;

  AppDatabase? database;

  List<PieChartSectionData> pieChartData = [];

  List colors = [
    Colors.grey,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.tealAccent,
    Colors.red,
    Colors.purple,
    Colors.pink,
  ];

  List<ChartDataModel> chartData = [];
  List<ExpenseTableData> expenseData = [];

  @override
  void onReady() async {
    expenseData = await database!.getAllData();
    for (var element in expenseData) {
      var totalAmount = 0.0;
      for (var value in expenseData) {
        if(element.category == value.category){
          totalAmount += double.parse(element.amount);
        }
      }
      chartData.add(
        ChartDataModel(title: " ", category: element.category, amount: totalAmount)
      );
      update();
    }
    super.onReady();
  }

  List<PieChartSectionData> chartSections(List<ChartDataModel> sectors) {
    final List<PieChartSectionData> list = [];
    for (int i = 0; i < sectors.length; i++) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: colors[i],
        value: sectors[i].amount,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }

  @override
  void onInit() {
    database = AppDatabase();
    super.onInit();
  }

  // TODO: get old expenses
  Future<List<ExpenseTableData>> oldExpenses() async {
    List<ExpenseTableData> data = await database!.getAllData();
    return data;
  }
}

class ChartDataModel {
  String title;
  String category;
  double amount;

  ChartDataModel(
      {required this.title,
      required this.category,
      required this.amount,});
}
