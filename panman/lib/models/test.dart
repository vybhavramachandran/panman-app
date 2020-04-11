enum TestResult { TBD, Positive, Negative, Inconclusive }
enum TestReportStatus { Pending, Received }

class Test {
  DateTime testDate;
  String testCenterName;
  TestResult result;
  TestReportStatus reportStatus;

  Test({this.testDate, this.testCenterName, this.result, this.reportStatus});

  static getTestResultEnum(String testReportStatus, String testResult) {
    if (testReportStatus == "Pending") {
      return TestResult.TBD;
    } else {
      if (testResult == "Positive") {
        return TestResult.Positive;
      } else if (testResult == "Negative") {
        return TestResult.Negative;
      } else if (testResult == "Inconclusive") {
        return TestResult.Inconclusive;
      }
    }
  }

  static getTestReportStatusFromString(String testReportStatus) {
    if (testReportStatus == "Pending") {
      return TestReportStatus.Pending;
    } else if (testReportStatus == "Recieved") {
      return TestReportStatus.Received;
    }
  }

  static getStringFromTestResultEnum(TestResult result) {
    if (result == TestResult.Positive) {
      return "Positive";
    } else if (result == TestResult.Inconclusive) {
      return "Inconclusive";
    } else if (result == TestResult.Negative) {
      return "Negative";
    } else if (result == TestResult.TBD) {
      return "TBD";
    }
  }

  static getStringFromTestReportStatusEnum(TestReportStatus reportStatus) {
    if (reportStatus == TestReportStatus.Pending) {
      return "Pending";
    } else if (reportStatus == TestReportStatus.Received) {
      return "Received";
    }
  }

  Test.fromMap(Map data)
      : this(
          testDate: DateTime.parse(data['testDate']),
          testCenterName: data['testCenterName'],
          result: getTestResultEnum(data['reportStatus'], data['result']),
          reportStatus: getTestReportStatusFromString(data['reportStatus']),
        );

  Map<String, dynamic> toMap() {
    return {
      'testDate': testDate.toString(),
      'testCenterName': testCenterName,
      'result': getStringFromTestResultEnum(result),
      'reportStatus': getStringFromTestReportStatusEnum(reportStatus),
    };
  }
}
