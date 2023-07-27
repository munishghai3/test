import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/expense_controller.dart';

class ExpenseBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(ExpenseController());
  }

}