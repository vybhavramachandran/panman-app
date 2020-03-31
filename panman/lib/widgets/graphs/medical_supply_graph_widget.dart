import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class medicalSupplyUtilizationTimeStamp {
  final DateTime time;
  final int qtyleft;
  medicalSupplyUtilizationTimeStamp(this.time, this.qtyleft);
}

class medicalSuplyGraphWidget extends StatelessWidget {
  String medicalSupplyName;
  int quantityLeft;
  int willLastForInDays;

  medicalSuplyGraphWidget(
      {this.medicalSupplyName, this.quantityLeft, this.willLastForInDays});
  returnTimeSeriesGraph() {
    List<charts.Series<medicalSupplyUtilizationTimeStamp, DateTime>>
        actualSeries = [];

    @override
    final dummy_data = [
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 10), 100),
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 11), 80),
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 12), 60),
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 15), 40),
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 16), 210),
      new medicalSupplyUtilizationTimeStamp(new DateTime(2020, 03, 17), 180),
    ];

    actualSeries.add(charts.Series(
      domainFn: (medicalSupplyUtilizationTimeStamp util, _) => util.time,
      measureFn: (medicalSupplyUtilizationTimeStamp util, _) => util.qtyleft,
      id: 'Utilization',
      data: dummy_data,
    ));

    return new charts.TimeSeriesChart(
      actualSeries,
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      animate: true,
      domainAxis: new charts.DateTimeAxisSpec(
          showAxisLine: false, renderSpec: new charts.NoneRenderSpec()),
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      // customSeriesRenderers: [
      //   new charts.PointRendererConfig(
      //       // ID used to link series to this renderer.
      //       customRendererId: 'customPoint')
      // ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  returnMedicalSupplCard() {
    return Card(
      elevation: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(child:Text(
                this.medicalSupplyName,
                style: TextStyle(fontWeight: FontWeight.w800,color:Colors.black54),
              )),
            
           Center(child:Text(
                this.quantityLeft.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800,color: willLastForInDays>5?Colors.black:Colors.red),
              )),
            Center(child:Text(
                "$willLastForInDays Days supply left",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              )),
            
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: returnMedicalSupplCard(),
    );
  }
}
