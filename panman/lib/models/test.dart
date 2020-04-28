import 'package:cloud_firestore/cloud_firestore.dart';


class Test {
  bool isSelfInitiated;
  String id;
  DateTime resultDate;
  String testCenterName;
  String result;

  Test(
      {this.id,
      this.isSelfInitiated,
      this.testCenterName,
      this.result,
      this.resultDate});

  Test.fromMap(Map data)
      : this(
          id: data['id'],
          isSelfInitiated : data['isSelfInitiated'],
          testCenterName: data['testCenterName'],
          result: data['result'],
          resultDate: data['resultDate'].toDate(),
        );

  Map<String, dynamic> toMap() {
    return {
      'resultDate': Timestamp.fromDate(resultDate),
      'testCenterName': testCenterName,
      'result': result,
      'isSelfInitiated': isSelfInitiated,
      'id': id,
    };
  }
}
