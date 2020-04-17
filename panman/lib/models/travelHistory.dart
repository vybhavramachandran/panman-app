import 'package:cloud_firestore/cloud_firestore.dart';

class TravelHistory {
  String countryVisited;
  DateTime arrivalDate;

  TravelHistory({this.countryVisited, this.arrivalDate});

  TravelHistory.fromMap(Map data)
      : this(
          countryVisited: data['countryVisited'],
          arrivalDate: data['arrivalDate'].toDate(),
        );

  Map<String, dynamic> toMap() {
    return {
      'countryVisited': countryVisited,
      'arrivalDate': Timestamp.fromDate(arrivalDate),
    };
  }
}
