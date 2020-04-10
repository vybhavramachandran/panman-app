
import 'package:cloud_firestore/cloud_firestore.dart';

class event {
  String eventID;
  String eventType;
  DateTime eventDateTime;
  String eventData;

  event({
    this.eventID,
    this.eventType,
    this.eventDateTime,
    this.eventData,
  });

  
  event.fromMap(Map data)
      : this(
          eventID: data['eventID'],
          eventType: data['eventType'],
          eventDateTime: DateTime.parse(data['eventDateTime']),
          eventData: data['eventData'],
        );

  Map<String, dynamic> toMap() {
    return {
      'eventID': eventID,
      'eventType': eventType,
      'eventDateTime': eventDateTime.toString(),
      'eventData': eventData,
    };
  }
}
