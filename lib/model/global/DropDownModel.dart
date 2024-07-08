class DropDownModel {
  String name;
  String value;

  DropDownModel({required this.name, required this.value});
}

class ActionTypeModel {
  final String name;
  final Function() onTap;

  ActionTypeModel({required this.name, required this.onTap});
}
