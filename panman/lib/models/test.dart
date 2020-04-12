class Test {
  String id;
  DateTime submissionDate;
  DateTime resultDate;
  String testCenterName;
  String result;
  String reportStatus;

  Test(
      {this.submissionDate,
      this.testCenterName,
      this.result,
      this.reportStatus,
      this.resultDate});

  Test.fromMap(Map data)
      : this(
          submissionDate: DateTime.parse(data['submissionDate']),
          testCenterName: data['testCenterName'],
          result: data['result'],
          reportStatus: data['reportStatus'],
          resultDate: data['resultDate'],
        );

  Map<String, dynamic> toMap() {
    return {
      'resultDate': resultDate.toString(),
      'testCenterName': testCenterName,
      'result': result,
      'reportStatus': reportStatus,
      'submissionDate': submissionDate.toString(),
    };
  }
}
