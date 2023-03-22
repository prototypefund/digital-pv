import 'package:pd_app/general/dynamic_content/components/contextual_help.dart';

class Group {
  Group({required this.title, required this.children});

  String title;
  List<Item> children;
}

class Item {
  Item({required this.title, this.help});

  String title;
  ContextualHelp? help;

  bool isExpanded = false;
}
