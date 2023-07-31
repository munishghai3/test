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
    expenseData.forEach((element) {

    });
    super.onReady();
  }

  List<PieChartSectionData> chartSections(List<ExpenseTableData> sectors) {
    final List<PieChartSectionData> list = [];
    for (int i = 0; i < sectors.length; i++) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: colors[i],
        value: int.parse(sectors[i].amount).toDouble(),
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
  Color color;

  ChartDataModel(
      {required this.title,
      required this.category,
      required this.amount,
      required this.color});
}
