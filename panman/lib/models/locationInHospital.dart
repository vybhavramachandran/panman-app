import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class locationInHospital {
  String id;
  String name;
  int count;
  int capacity;

  locationInHospital({this.id, this.name, this.count, this.capacity});

  locationInHospital.fromMap(Map data)
      : this(
          id: data['id'],
          name: data['name'],
          count: data['count'],
          capacity : data['capacity'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'count': count,
      'capacity':capacity,
    };
  }
}
