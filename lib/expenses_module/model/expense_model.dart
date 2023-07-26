class ExpenseModel{

  String title;
  String category;
  double amount;

  ExpenseModel({required this.title,required this.category, required this.amount});

}


DropListModel dropListModel = DropListModel([
  OptionItem(id: "1", title: "Food"),
  OptionItem(id: "2", title: "Transportation"),
  OptionItem(id: "3", title: "Utilities"),
  OptionItem(id: "4", title: "Shopping"),
]);
OptionItem optionItemSelected = OptionItem(id: "", title: "Select Category");

class DropListModel {
  DropListModel(this.listOptionItems);

  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final String id;
  final String title;

  OptionItem({required this.id, required this.title});
}

