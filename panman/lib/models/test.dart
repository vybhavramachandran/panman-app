class Test {
  String id;
  DateTime resultDate;
  String testCenterName;
  String result;

  Test(
      {
        this.id,
      this.testCenterName,
      this.result,
      this.resultDate});

  Test.fromMap(Map data)
      : this(
          id: data['id'],
          testCenterName: data['testCenterName'],
          result: data['result'],
          resultDate: DateTime.parse(data['resultDate']),
        );

  Map<String, dynamic> toMap() {
    return {
      'resultDate': resultDate.toString(),
      'testCenterName': testCenterName,
      'result': result,
      'id': id,
    };
  }
}
