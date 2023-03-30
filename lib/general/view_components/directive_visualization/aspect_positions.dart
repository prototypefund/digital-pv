import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/aspect_with_simulation.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/view_components/directive_visualization/coordinate.dart';
import 'package:pd_app/general/view_components/directive_visualization/sector.dart';

class AspectPositions {
  final List<Aspect> aspects;
  final Sector sector;

  AspectPositions({required this.aspects, required this.sector});

  List<AspectVisualizationInformation> get listOfAspectVisualizationInformation {
return aspects.asMap().entries.map((entry) {
    final aspect = entry.value;
    final bool active = (aspect is AspectWithSimulation) ? aspect.simulateAspect : true;

    return AspectVisualizationInformation(
      coordinate: _listOfCoordinates[entry.key],
      weight: aspect.weight,
      active: active,
    );
  }).toList();
  }

  List<Coordinate> get _listOfCoordinates {
    // get correct aspect amount distribution over sub sectors
    final List<int> aspectsOverSubSector = _amountOfAspectsOverSectorList(aspects.length);

    // get amount of sub sectors needed
    final int amountOfSectors = aspectsOverSubSector.length;

    // get angle for each sub sector
    final double subSectorAngle = sector.angle / amountOfSectors;
    final Sector subSector = Sector(angle: subSectorAngle, radius: sector.radius);

    final List<Coordinate> listOfAspectCoordinates = [];
    for (int i = 0; i < amountOfSectors; i++) {
      List<Coordinate> subSectorCoordinateList =
          _subSectorCoordinateList(aspectsPerSector: aspectsOverSubSector[i], sector: subSector);

      // adjust angle of every aspect in sub sector
      subSectorCoordinateList = subSectorCoordinateList
          .map((e) => Coordinate(radius: e.radius, angle: e.angle + subSectorAngle * i))
          .toList();

      listOfAspectCoordinates.addAll(subSectorCoordinateList);
    }

    return listOfAspectCoordinates;
  }

  List<Coordinate> _subSectorCoordinateList({required int aspectsPerSector, required Sector sector}) {
    switch (aspectsPerSector) {
      case 1:
        return [sector.innerMiddleCoordinate];
      case 2:
        return [sector.innerMiddleCoordinate, sector.outerRightCoordinate];
      case 3:
        return [sector.innerMiddleCoordinate, sector.outerRightCoordinate, sector.outerLeftCoordinate];
      default:
        return [
          sector.innerMiddleCoordinate,
          sector.outerRightCoordinate,
          sector.outerLeftCoordinate,
          sector.outerMiddleCoordinate,
        ];
    }
  }

  /// Distribution Algorithm of aspects
  ///
  /// Divides total amount of Aspects over several smaller Sectors
  /// returns List with amount of Aspects for each Sector
  ///
  List<int> _amountOfAspectsOverSectorList(int amountOfAspectsLeft) {
    final List<int> finalList = [];
    switch (amountOfAspectsLeft) {
      case 0:
        return finalList;
      case 1:
      case 2:
      case 3:
      case 4:
        finalList.add(amountOfAspectsLeft);
        return finalList;
      case 5:
      case 6:
        finalList.add(3);
        finalList.addAll(_amountOfAspectsOverSectorList(amountOfAspectsLeft - 3));
        return finalList;
      default:
        finalList.add(4);
        finalList.addAll(_amountOfAspectsOverSectorList(amountOfAspectsLeft - 4));
        return finalList;
    }
  }
}

class AspectVisualizationInformation {
  final Coordinate coordinate;
  final Weight weight;
  final bool active;

  const AspectVisualizationInformation({required this.coordinate, required this.weight, required this.active});

  @override
  String toString() {
    return 'AspectVisualizationInformation: coordinate = $coordinate, weight = $weight, active = $active';
  }
}
