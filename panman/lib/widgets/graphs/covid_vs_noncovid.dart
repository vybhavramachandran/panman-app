import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../providers/patients.dart';

class covidvsnoncovid {
  final String testResult;
  final int count;
  covidvsnoncovid(this.testResult,this.count);
}

class returncovidvsnoncovidgraph extends StatelessWidget {
  graphMeUp(BuildContext context) {
    List<charts.Series<covidvsnoncovid, String>> actualSeries = [];
    List results = Provider.of<Patients>(context,listen:false).getCovidvsNonCovidforDashboard();
    @override
    final dummy_count_data = [
      new covidvsnoncovid("Negative", results[1]),
      new covidvsnoncovid("Positive", results[0]),
    ];

    actualSeries.add(new charts.Series<covidvsnoncovid, String>(

      id: 'covidStatusCount',
      domainFn: (covidvsnoncovid status, _) =>
          status.testResult,
      measureFn: (covidvsnoncovid status, _) => status.count,
      data: dummy_count_data,
  //    areaColorFn: ,
     // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      colorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter,

    //  seriesColor : MaterialColor(actualSeries),
      labelAccessorFn: (covidvsnoncovid status, _) =>
          '${status.testResult}:${status.count.toString()}',
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
      child: graphMeUp(context),
    );
  }
}
