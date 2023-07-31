import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/add_expense_controller.dart';
import 'package:test_project/expenses_module/model/expense_model.dart';

class AddExpensesScreen extends GetView<AddExpenseController> {
  final categoryFormKey = new GlobalKey<FormState>();

  AddExpensesScreen({super.key});

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
                _titleTextField(),
                _amountTextField(),
                _categoryDropDown(),
                _addCategory(),
                _submitButton(),
              ]),
        ),
      ),
    );
  }

  _titleTextField() =>  TextFormField(
    controller: controller.titleController,
    textInputAction: TextInputAction.next,
    focusNode: controller.titleNode,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      hintText: "Enter title",
      label: Text("Title"),
    ),
    validator: (input) => (controller.title.isEmpty)
        ? 'Please enter something'
        : null,
    onChanged: (input) => controller.title = input!,
  );

  _amountTextField() => TextFormField(
    controller: controller.amountController,
    textInputAction: TextInputAction.next,
    focusNode: controller.amountNode,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: const InputDecoration(
      hintText: "Enter Amount",
      label: Text("Amount"),
    ),
    validator: (input) => (controller.amount.isEmpty)
        ? 'Please enter something'
        : null,
    onChanged: (input) => controller.amount = input!,
  );

  _categoryDropDown() => Container(
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
                "${optionItemSelected.title}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Icon(
                controller.isShow
                    ? Icons.arrow_drop_down
                    : Icons.arrow_right,
                // size: 25,
              ),
            ],
          ),
        ),
      ),
      Divider(color: Colors.grey.shade400, height: 1),
      const SizedBox(
        height: 5,
      ),
      SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: controller.animation,
          child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 10),
              height: dropListModel.listOptionItems.length <5 ? dropListModel.listOptionItems.length*30: 5*30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(Get.context!).dialogBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
              ),
              child: Scrollbar(
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus
                              ?.unfocus();
                          var optionItemSelected =
                          dropListModel
                              .listOptionItems[index];
                          controller.isShow = false;
                          controller.expandController
                              .reverse();
                          controller.category =
                              optionItemSelected.id;
                          debugPrint(controller.category);
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Text(
                            dropListModel
                                .listOptionItems[index].title,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const Divider(),
                      itemCount:
                      dropListModel.listOptionItems.length))))
    ]),
  );
  
  _addCategory()=> Align(
    alignment: Alignment.centerRight,
    child: InkWell(
      onTap: (){
        _addCategoryDialog();
      },
      child: Text(
        "+ Add More category",
        style: TextStyle(
          color: Colors.blue
        ),
      )
    ),
  ).paddingOnly(top: 10);

  _addCategoryDialog() => Get.dialog(
      GetBuilder<AddExpenseController>(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
              alignment: Alignment.center,
              child: Container(
                height:  200,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  horizontal: 20
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add category",
                      style: TextStyle(
                          color: Colors.blue,
                        fontSize: 18
                      ),
                    ),
                    Form(
                      key: categoryFormKey,
                      child: TextFormField(
                        controller: controller.addCategoryController,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.focusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Enter Category",
                        ),
                        validator: (input) => (input == null || input == "")
                            ? 'Please enter something'
                            : null,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if(categoryFormKey.currentState!.validate()){
                                controller.addCategory();
                                controller.update();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 15)
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
          );
        }
      )
  );

  _submitButton() => InkWell(
    onTap: () {
      controller.submit();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 10),
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
  ).paddingSymmetric(vertical: 30);
}
