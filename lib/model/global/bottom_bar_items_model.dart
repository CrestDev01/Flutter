class BottomBarItemsModel {
  String? itemName;
  String? icon;
  String? selectedIcon;
  bool showCount;
  int count;

  BottomBarItemsModel({
    required this.itemName,
    required this.icon,
    required this.selectedIcon,
    this.showCount = false,
    this.count = 0,
  });
}
