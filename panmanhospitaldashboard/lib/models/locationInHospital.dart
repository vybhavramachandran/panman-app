import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class locationInHospital {
  int levelNumber;
  String name;
  int count;

  locationInHospital({this.levelNumber, this.name, this.count});

  locationInHospital.fromMap(Map data)
      : this(
          levelNumber: data['levelNumber'],
          name: data['name'],
          count: data['count'],
        );

  Map<String, dynamic> toMap() {
    return {
      'level': levelNumber,
      'name': name,
      'count': count,
    };
  }
}
