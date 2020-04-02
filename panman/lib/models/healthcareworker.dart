import 'package:flutter/cupertino.dart';
import './roles.dart';

class HealthCareWorker {
  String firstName;
  String lastName;
  String role;
  String uid;
  String hospitalID;

  HealthCareWorker(
      {this.firstName, this.lastName, this.role, this.uid, this.hospitalID});

  HealthCareWorker.fromMap(Map data)
      : this(
          firstName: data['firstName'],
          lastName: data['lastName'],
          role: data['role'],
          uid: data['uid'],
          hospitalID: data['hospitalID'],
        );

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'uid': uid,
      'hospitalID': hospitalID,
    };
  }

  mapifyList(List input) {
    List<Map> newList = [];

    input.forEach((item) {
      newList.add(item.toMap());
    });

    return newList.toList();
  }
}
