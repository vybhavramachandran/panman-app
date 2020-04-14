class TravelHistory {
  String countryVisited;
  DateTime arrivalDate;

  TravelHistory({this.countryVisited, this.arrivalDate});

  TravelHistory.fromMap(Map data)
      : this(
          countryVisited: data['countryVisited'],
          arrivalDate: DateTime.parse(data['arrivalDate']),
        );

  Map<String, dynamic> toMap() {
    return {
      'countryVisited': countryVisited,
      'arrivalDate': arrivalDate.toString(),
    };
  }
}
