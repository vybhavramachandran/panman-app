import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import '../../providers/patients.dart';

class covidStatusCount {
  final String covidStatus;
  final int count;
  covidStatusCount(this.covidStatus, this.count);
}

class returnCovidStatusGraph extends StatelessWidget {
  graphMeUp(BuildContext context) {
    List results = Provider.of<Patients>(context, listen: false)
        .getCovid19SummaryForTheDashboard();
    List<charts.Series<covidStatusCount, String>> actualSeries = [];
    @override
    final dummy_count_data = [
      new covidStatusCount("AS-1", results[0]),
      new covidStatusCount("AS-2", results[1]),
      new covidStatusCount("S-1", results[2]),
      new covidStatusCount("S-2", results[3]),
      new covidStatusCount("S-3", results[4]),
      new covidStatusCount("S-4", results[5]),
      new covidStatusCount("S-5", results[6]),
      new covidStatusCount("S-6", results[7]),
    ];

    actualSeries.add(new charts.Series<covidStatusCount, String>(
      id: 'covidStatusCount',
      domainFn: (covidStatusCount status, _) => status.covidStatus,
      measureFn: (covidStatusCount status, _) => status.count,
      data: dummy_count_data,
      // fillColorFn: (covidStatusCount ,value){
      //   return
      // },
      //    areaColorFn: ,
      // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
      labelAccessorFn: (covidStatusCount status, _) =>
          '${status.covidStatus}:${status.count.toString()}',
    ));

    return new charts.PieChart(
      actualSeries,
      defaultInteractions: true,
      defaultRenderer: new charts.ArcRendererConfig(
          arcRatio: 0.7,
          arcWidth: 60,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside)
          ]),
      animate: true,
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: graphMeUp(context),
    );
  }
}
