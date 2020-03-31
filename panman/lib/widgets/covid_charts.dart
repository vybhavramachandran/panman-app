import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/medicalSupply.dart';
import './graphs/medical_supply_graph_widget.dart';
import './graphs/covid_patient_status.dart';
import './graphs/covid_vs_noncovid.dart';


import '../providers/hospital.dart';
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END

class CovidCharts extends StatelessWidget {
  String title;
  Color backgroundColor;

  CovidCharts({this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 6,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PageView(
                      children: <Widget>[
                        returnCovidStatusGraph(),
                        returncovidvsnoncovidgraph(),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w800))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
