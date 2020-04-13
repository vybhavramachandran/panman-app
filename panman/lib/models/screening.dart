import './travelHistory.dart';

class Screening {
  bool hasCough;
  bool hasFever;
  bool hasTiredness;
  bool hasDifficultyBreathing;
  String visitedCountry;
  DateTime returnDate;
  bool hasComorbidityCOPD;
  bool hasTravelledAboard;
  bool hasComorbidityChronicRenalDisease;
  bool hasComorbidityMalignancy;
  bool hasComorbidityDiabetes;
  bool hasComorbidityHypertension;
  bool hasComorbidityPregnancy;
  bool hasComorbidityLiverDisease;
  bool hasComorbidityChronicNeuro;
  bool hasComorbidityHeartDisease;
  bool hasComorbidityHIV;
  bool hasComorbdityOrganTransplant;

  Screening({
    this.hasComorbdityOrganTransplant,
    this.hasComorbidityCOPD,
    this.hasTravelledAboard,
    this.hasComorbidityChronicNeuro,
    this.hasComorbidityChronicRenalDisease,
    this.hasComorbidityDiabetes,
    this.hasComorbidityHIV,
    this.hasComorbidityHeartDisease,
    this.hasComorbidityHypertension,
    this.hasComorbidityLiverDisease,
    this.hasComorbidityMalignancy,
    this.hasComorbidityPregnancy,
    this.hasCough,
    this.hasDifficultyBreathing,
    this.hasFever,
    this.hasTiredness,
    this.returnDate,
    this.visitedCountry,
  });

  mapifyList(List input) {
    List<Map> newList = [];

    input.forEach((item) {
      newList.add(item.toMap());
    });

    return newList.toList();
  }

  Screening.fromMap(Map data)
      : this(
          hasCough: data['hasCough'],
          hasComorbdityOrganTransplant: data['hasComorbdityOrganTransplant'],
          hasComorbidityCOPD: data['hasComorbidityCOPD'],
          hasComorbidityChronicNeuro: data['hasComorbidityChronicNeuro'],
          hasComorbidityChronicRenalDisease:
              data['hasComorbidityChronicRenalDisease'],
          hasComorbidityDiabetes: data['hasComorbidityDiabetes'],
          hasComorbidityHIV: data['hasComorbidityHIV'],
          hasComorbidityHeartDisease: data['hasComorbidityHeartDisease'],
          hasComorbidityHypertension: data['hasComorbidityHypertension'],
          hasComorbidityLiverDisease: data['hasComorbidityLiverDisease'],
          hasComorbidityMalignancy: data['hasComorbidityMalignancy'],
          hasComorbidityPregnancy: data['hasComorbidityPregnancy'],
          hasFever: data['hasFever'],
          hasTiredness: data['hasTiredness'],
          hasDifficultyBreathing: data['hasDifficultyBreathing'],
          visitedCountry: data['visitedCountry'],
          returnDate: DateTime.parse(data['returnDate']),
          hasTravelledAboard :data['hasTravelledAboard'],
        );

  Map<String, dynamic> toMap() {
    return {
      'hasCough':hasCough,
      'hasFever':hasFever,
      'hasTiredness':hasTiredness,
      'hasDifficultyBreathing':hasDifficultyBreathing,
      'visitedCountry':visitedCountry,
      'returnDate':returnDate.toString(),
      'hasComorbidityCOPD':hasComorbidityCOPD,
      'hasComorbidityChronicRenalDisease':hasComorbidityChronicRenalDisease,
      'hasComorbidityDiabetes':hasComorbidityDiabetes,
      'hasComorbidityHypertension':hasComorbidityHypertension,
      'hasComorbidityPregnancy':hasComorbidityPregnancy,
      'hasComorbidityLiverDisease':hasComorbidityLiverDisease,
      'hasComorbidityChronicNeuro':hasComorbidityChronicNeuro,
      'hasComorbidityHeartDisease':hasComorbidityHeartDisease,
      'hasComorbidityHIV':hasComorbidityHIV,
      'hasComorbdityOrganTransplant':hasComorbdityOrganTransplant,
      'hasTravelledAboard':hasTravelledAboard,
    };
  }
}
