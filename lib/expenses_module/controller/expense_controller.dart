import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_project/database/drift_database.dart';
import 'package:test_project/expenses_module/view/expences_home.dart';
import 'package:test_project/utils/common_utility.dart';

import '../model/expense_model.dart';

class ExpenseController extends GetxController {

  static final _formKey = new GlobalKey<FormState>();

TextEditingController titleController = TextEditingController();
TextEditingController amountController = TextEditingController();

FocusNode titleNode = FocusNode();
FocusNode amountNode = FocusNode();

AppDatabase? database = AppDatabase();
  var categoryId;

bool isShow = false;
late AnimationController expandController;
late Animation<double> animation;
late FocusNode focusNode;

String title = "";

String amount = "";

String? category = "";


@override
void onInit() {
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
  if (_formKey.currentState!.validate()) {
    if(category != ""){
    title = titleController.text;
    amount = amountController.text;
     categoryId = await database!
        .insertMedicine(ExpenseTableCompanion.insert(
      title: title,
      amount: amount,
      category: category!,
    ),).then((value) => Get.to(HomeScreen(categoryId: categoryId)));
    debugPrint("data inserted ${categoryId.toString()}");
    }
else{
  Utility().toast(Get.context!, "Select something");
    }
  }}




  List<ExpenseModel> expences = [

  ];

  //TODO: return List of category list
  List<String> categoryList() {
    List<String> categories = [

    ]; //take static data of your choice
    return categories;
  }


//TODO: add expense to expense list
void addExpense(){
  ExpenseModel expense = ExpenseModel(title : "" , category : "", amount : 0);
  expences.add(expense);
  }


// TODO: get old expenses
void oldExpenses(){
    var oldExpenses = [

    ];
    expences = oldExpenses;
}
//TODO: validation for add expence
  void validation(){}
//TODO: getItem by category
expencesByCategory(String category){
    return expences.where((element)=>element.category == category).toList();
}

//TODO: return List of category list



}