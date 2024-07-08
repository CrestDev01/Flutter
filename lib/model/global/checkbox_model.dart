class CheckBoxModel {
  String name;
  String? description;
  bool value;

  CheckBoxModel({
    required this.name,
    required this.value,
    this.description,
  });
}
