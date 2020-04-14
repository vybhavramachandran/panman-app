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
          resultDate: DateTime.parse(data['resultDate']),
          requestedDate: DateTime.parse(data['requestedDate']),
        );

  Map<String, dynamic> toMap() {
    return {
      'resultDate': resultDate.toString(),
      'requestedDate': requestedDate!=null?requestedDate.toString():"",
      'testCenterName': testCenterName,
      'result': result,
      'isSelfInitiated': isSelfInitiated,
      'id': id,
    };
  }
}
