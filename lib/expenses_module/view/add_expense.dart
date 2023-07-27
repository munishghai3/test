import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/expense_controller.dart';
import 'package:test_project/expenses_module/model/expense_model.dart';

class AddExpensesScreen extends GetView<ExpenseController> {
  const AddExpensesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          TextFormField(
            controller: controller.titleController,
            textInputAction: TextInputAction.next,
            focusNode: controller.titleNode,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter title",
              label: Text("Title"),
            ),
            validator: (input) =>
            (controller.title.isEmpty) ? 'Please enter something' : null,
            onChanged: (input) => controller.title = input!,
          ),

          TextFormField(
            controller: controller.amountController,
            textInputAction: TextInputAction.next,
            focusNode: controller.amountNode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: "Enter Amount",
              label: Text("Amount"),
            ),
            validator: (input) =>
            (controller.amount.isEmpty) ? 'Please enter something' : null,
            onChanged: (input) => controller.amount = input!,
          ),


              Container(
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 17, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.isShow = !controller.isShow;
                        controller.runExpandCheck();
                        controller.update();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${optionItemSelected.title}", style: TextStyle(
                              fontSize: 16,),
                          ),

                          Icon(
                            controller.isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                            // size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade400, height: 1),
               SizedBox(height: 5,),
               SizeTransition(
                      axisAlignment: 1.0,
                      sizeFactor: controller.animation,
                      child: Container(
                          height: dropListModel.listOptionItems.length <5 ? dropListModel.listOptionItems.length*30: 5*30,

                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Theme.of(context).dialogBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black26,
                                  offset: Offset(0, 4))
                            ],
                          ),
                          child: Scrollbar(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                     var optionItemSelected =
                                      dropListModel
                                          .listOptionItems[index];
                                      controller.isShow = false;
                                      controller.expandController.reverse();
                                      controller.category = optionItemSelected.title;
                                      print(controller.category);
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10, bottom: 10),
                                      child: Text(
                                        dropListModel
                                            .listOptionItems[index].title,
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount:
                                  dropListModel.listOptionItems.length))))

                ]),
              ),

              InkWell(
                onTap: () {
                  controller.submit();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

        ]),
      ),
    ),
  );
  }
  }



