import 'package:pd_app/general/model/weight.dart';

class Aspect {
  Aspect({required this.name, this.description, required this.weight});

  final String name;
  final String? description;
  Weight weight;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aspect &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          weight == other.weight;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ weight.hashCode;
}
