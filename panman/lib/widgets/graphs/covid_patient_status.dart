import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class covidStatusCount {
  final String covidStatus;
  final int count;
  covidStatusCount(this.covidStatus,this.count);
}

class returnCovidStatusGraph extends StatelessWidget {
  graphMeUp() {
    List<charts.Series<covidStatusCount, String>> actualSeries = [];

    @override
    final dummy_count_data = [
      new covidStatusCount("AS-1", 200),
      new covidStatusCount("AS-2", 20),
      new covidStatusCount("S-1", 30),
      new covidStatusCount("S-2", 100),
      new covidStatusCount("S-3", 15),
      new covidStatusCount("S-4", 10),
      new covidStatusCount("S-5", 5),
    ];

    actualSeries.add(new charts.Series<covidStatusCount, String>(

      id: 'covidStatusCount',
      domainFn: (covidStatusCount status, _) =>
          status.covidStatus,
      measureFn: (covidStatusCount status, _) => status.count,
      data: dummy_count_data,
      // fillColorFn: (covidStatusCount ,value){
      //   return
      // },
  //    areaColorFn: ,
     // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      colorFn: (_, __) =>
            charts.MaterialPalette.red.shadeDefault.lighter,
      labelAccessorFn: (covidStatusCount status, _) =>
          '${status.covidStatus}:${status.count.toString()}',
    ));

    return new charts.PieChart(actualSeries,
    defaultInteractions: true,

    defaultRenderer: new charts.ArcRendererConfig(
      arcRatio: 0.7,
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.outside)]),
        animate: true,);
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: graphMeUp(),
    );
  }
}
