class Group {
  Group({required this.title, required this.children});

  String title;
  List<Item> children;
}

class Item {
  Item({required this.title, this.description});

  String title;
  String? description;

  String get titleWithDescription {
    return "$title\n${description ?? ""}";
  }

  bool isExpanded = false;
}
