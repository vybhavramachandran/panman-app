import 'package:cloud_firestore/cloud_firestore.dart';


class Test {
  bool isSelfInitiated;
  String id;
  DateTime resultDate;
  DateTime requestedDate;
  String testCenterName;
  String result;

  Test(
      {this.id,
      this.isSelfInitiated,
      this.testCenterName,
      this.result,
      this.requestedDate,
      this.resultDate});

  Test.fromMap(Map data)
      : this(
          id: data['id'],
          isSelfInitiated : data['isSelfInitiated'],
          testCenterName: data['testCenterName'],
          result: data['result'],
          resultDate: data['resultDate'].toDate(),
          requestedDate: data['requestedDate'].toDate(),
        );

  Map<String, dynamic> toMap() {
    return {
      'resultDate': Timestamp.fromDate(resultDate),
      'requestedDate': Timestamp.fromDate(requestedDate),
      'testCenterName': testCenterName,
      'result': result,
      'isSelfInitiated': isSelfInitiated,
      'id': id,
    };
  }
}
