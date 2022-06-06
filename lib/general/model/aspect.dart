import 'package:pd_app/general/model/weight.dart';

class Aspect {
  final String name;
  final String? description;
  Weight weight;

  Aspect({required this.name, this.description, required this.weight});
}
