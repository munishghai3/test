import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/view/expences_home.dart';
import 'package:test_project/utils/common_utility.dart';

import '../model/expense_model.dart';

class ExpenseController extends GetxController with GetTickerProviderStateMixin{
   final formKey = new GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  FocusNode titleNode = FocusNode();
  FocusNode amountNode = FocusNode();
  FocusNode focusNode = FocusNode();

  AppDatabase? database;
  var categoryId;

  bool isShow = false;
  late AnimationController expandController;
  late Animation<double> animation;

  String title = "";

  String amount = "";

  String? category = "";

  @override
  void onInit() {
    database    = AppDatabase();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isShow = false;
        runExpandCheck();
      }
    });
    focusNode = FocusNode();
    runExpandCheck();
    super.onInit();
  }

  void runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      if (category != "") {
        title = titleController.text;
        amount = amountController.text;
        categoryId = await database!
            .insertData(
              ExpenseTableCompanion.insert(
                title: title,
                amount: amount,
                category: category!,
              ),
            );
           Get.back();
        debugPrint("data inserted ${categoryId.toString()}");
        update();
      } else {
        Utility().toast(Get.context!, "Select something");
      }
    }
  }

  List<ExpenseModel> expences = [];

  //TODO: return List of category list
  List<String> categoryList() {
    List<String> categories = []; //take static data of your choice
    return categories;
  }

//TODO: add expense to expense list
  void addExpense() {
    ExpenseModel expense = ExpenseModel(title: "", category: "", amount: 0);
    expences.add(expense);
  }

// TODO: get old expenses
  Future<List<ExpenseTableData>> oldExpenses() async{
    List<ExpenseTableData> data = await database!.getAllData();
    return data;
  }

//TODO: validation for add expence
  void validation() {}

//TODO: getItem by category
  expencesByCategory(String category) {
    return expences.where((element) => element.category == category).toList();
  }

}
