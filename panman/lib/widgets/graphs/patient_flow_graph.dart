import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../providers/hospital.dart';
import '../../models/hospital.dart';



class locationInHospitalCount {
  final String locationInHospitalName;
  final int count;
  locationInHospitalCount(this.locationInHospitalName, this.count);
}

class returnPatientFlowGraph extends StatelessWidget {
  graphMeUp(BuildContext context) {
    List<charts.Series<locationInHospitalCount, String>> actualSeries = [];
    
    @override
    final dummy_count_data = [
      new locationInHospitalCount("Reg.", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[1].count),
      new locationInHospitalCount("Screening", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[2].count),
      new locationInHospitalCount("Holding", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[3].count),
      new locationInHospitalCount("Isolation", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[4].count),
      new locationInHospitalCount("ICU", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[5].count),
    ];

    final dummy_capacity_lines_data = [
      new locationInHospitalCount("Reg.", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[1].capacity),
      new locationInHospitalCount("Screening", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[2].capacity),
      new locationInHospitalCount("Holding", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[3].capacity),
      new locationInHospitalCount("Isolation", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[4].capacity),
      new locationInHospitalCount("ICU", Provider.of<Hospitals>(context,listen:false).fetchedHospital.locations[5].capacity),
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
      child: graphMeUp(context),
    );
  }
}
