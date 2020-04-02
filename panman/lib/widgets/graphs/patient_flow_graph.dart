import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class locationInHospitalCount {
  final String locationInHospitalName;
  final int count;
  locationInHospitalCount(this.locationInHospitalName, this.count);
}

class returnPatientFlowGraph extends StatelessWidget {
  graphMeUp() {
    List<charts.Series<locationInHospitalCount, String>> actualSeries = [];

    @override
    final dummy_count_data = [
      new locationInHospitalCount("Reg.", 200),
      new locationInHospitalCount("Screening", 20),
      new locationInHospitalCount("Holding", 30),
      new locationInHospitalCount("Isolation", 100),
      new locationInHospitalCount("ICU", 15),
    ];

    final dummy_capacity_lines_data = [
      new locationInHospitalCount("Reg.", 160),
      new locationInHospitalCount("Screening", 15),
      new locationInHospitalCount("Holding", 50),
      new locationInHospitalCount("Isolation", 80),
      new locationInHospitalCount("ICU", 10),
    ];

    actualSeries.add(new charts.Series<locationInHospitalCount, String>(
      id: 'hospital',
      domainFn: (locationInHospitalCount location, _) =>
          location.locationInHospitalName,
      measureFn: (locationInHospitalCount location, _) => location.count,
      data: dummy_count_data,
     // colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      labelAccessorFn: (locationInHospitalCount loc, _) =>
          '${loc.count.toString()}',
    ));

    actualSeries.add(
      new charts.Series<locationInHospitalCount, String>(
        id: 'Target Line',
        domainFn: (locationInHospitalCount location, _) =>
            location.locationInHospitalName,
        measureFn: (locationInHospitalCount location, _) => location.count,
        data: dummy_capacity_lines_data,
        colorFn: (_, __) => charts.MaterialPalette.black,
      )..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    );

    return new charts.BarChart(actualSeries,
        animate: true,
        //   behaviors: [
        //   // Add the sliding viewport behavior to have the viewport center on the
        //   // domain that is currently selected.
        //   new charts.SlidingViewport(),
        //   // A pan and zoom behavior helps demonstrate the sliding viewport
        //   // behavior by allowing the data visible in the viewport to be adjusted
        //   // dynamically.
        //   new charts.PanAndZoomBehavior(),
        // ],
        barRendererDecorator: new charts.BarLabelDecorator<String>(),

        //     vertical: false,
        domainAxis: new charts.OrdinalAxisSpec(
            //           viewport: new charts.OrdinalViewport('AePS', 3),

            renderSpec: new charts.SmallTickRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 10, // size in Pts.
                    color: charts.MaterialPalette.black),
                lineStyle: new charts.LineStyleSpec(
                    thickness: 0, color: charts.MaterialPalette.black))),
        primaryMeasureAxis:
            new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
        // new charts.NumericAxisSpec(
        //     renderSpec: new charts.GridlineRendererSpec(
        //         labelStyle: new charts.TextStyleSpec(
        //             fontSize: 18, // size in Pts.
        //             color: charts.MaterialPalette.black),
        //         lineStyle: new charts.LineStyleSpec(
        //             color: charts.MaterialPalette.black))),
        customSeriesRenderers: [
          new charts.BarTargetLineRendererConfig<String>(
            customRendererId: 'customTargetLine',
          )
        ]);
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: graphMeUp(),
    );
  }
}