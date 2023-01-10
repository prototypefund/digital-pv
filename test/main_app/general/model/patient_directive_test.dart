import 'package:flutter_test/flutter_test.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/model/weight.dart';

void main() {
  test("test current aspect score without aspects", () {
    final PatientDirective instance = PatientDirective(
        positiveAspects: [],
        futureSituationAspects: [],
        negativeAspects: [],
        generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, 0);
  });
  test("test current aspect score with only one positive aspects", () {
    final PatientDirective instance = PatientDirective(
        positiveAspects: [Aspect(name: "test 1", weight: Weight(value: 0.7))],
        futureSituationAspects: [],
        negativeAspects: [],
        generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, 1.0);
  });
  test("test current aspect score with three positive aspects", () {
    final PatientDirective instance = PatientDirective(positiveAspects: [
      Aspect(
        name: "test 1",
        weight: Weight(value: 0.7),
      ),
      Aspect(
        name: "test 2",
        weight: Weight(value: 0.2),
      ),
      Aspect(
        name: "test 3",
        weight: Weight(value: 0.02),
      )
    ], futureSituationAspects: [], negativeAspects: [], generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, 1.0);
  });
  test("test current aspect score with only one negative aspect", () {
    final PatientDirective instance = PatientDirective(
        positiveAspects: [],
        futureSituationAspects: [],
        negativeAspects: [Aspect(name: "test 1", weight: Weight(value: 0.3))],
        generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, -1);
  });
  test("test current aspect score with three negative aspects", () {
    final PatientDirective instance =
        PatientDirective(positiveAspects: [], futureSituationAspects: [], negativeAspects: [
      Aspect(name: "test 1", weight: Weight(value: 0.5)),
      Aspect(name: "test 2", weight: Weight(value: 0.1)),
      Aspect(name: "test 3", weight: Weight(value: 0.6))
    ], generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, -1);
  });
  test("test current aspect score with mixed aspects but positive tendency", () {
    final PatientDirective instance = PatientDirective(positiveAspects: [
      Aspect(
        name: "test 1 pos",
        weight: Weight(value: 0.7),
      ),
      Aspect(
        name: "test 2 pos",
        weight: Weight(value: 0.2),
      ),
      Aspect(
        name: "test 3 pos",
        weight: Weight(value: 0.3),
      ) // sum 1.2
    ], futureSituationAspects: [], negativeAspects: [
      Aspect(
        name: "test 1 neg",
        weight: Weight(value: 0.3),
      ),
      Aspect(
        name: "test 2 neg",
        weight: Weight(value: 0.3),
      ),
      Aspect(
        name: "test 3 neg",
        weight: Weight(value: 0.2),
      ) // sum 0.8
    ], generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, closeTo(0.2, 0.0000000001));
  });
  test("test current aspect score with mixed aspects but negative tendency", () {
    final PatientDirective instance = PatientDirective(positiveAspects: [
      Aspect(
        name: "test 1 pos",
        weight: Weight(value: 0.3),
      ),
      Aspect(
        name: "test 2 pos",
        weight: Weight(value: 0.15),
      ),
      Aspect(
        name: "test 3 pos",
        weight: Weight(value: 0.4),
      ) // sum 0.85
    ], futureSituationAspects: [], negativeAspects: [
      Aspect(
        name: "test 1 neg",
        weight: Weight(value: 0.8),
      ),
      Aspect(
        name: "test 2 neg",
        weight: Weight(value: 0.7),
      ),
      Aspect(
        name: "test 3 neg",
        weight: Weight(value: 0.6),
      ) // sum 2..1
    ], generalTreatmentGoal: TreatmentGoal.undefined);

    expect(instance.currentAspectsScore, closeTo(-0.4237288136, 0.0000000001));
  });
}
