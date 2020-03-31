import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/medicalSupply.dart';
import './graphs/medical_supply_graph_widget.dart';
import './graphs/patient_flow_graph.dart';

import '../providers/hospital.dart';
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END

class PatientFlowCard extends StatelessWidget {
  String title;
  Color backgroundColor;

  PatientFlowCard({this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            // Flexible(
            //   flex: 1,
            //   child: Text(title,
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .copyWith(color: Colors.black)),
            // ),
            Flexible(
              flex: 6,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: returnPatientFlowGraph(),
                  ),
                  Align(
                    alignment:Alignment.topCenter,
                    child: Text(title,style:Theme.of(context).textTheme.headline5.copyWith(color:Colors.black,fontWeight: FontWeight.w800))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
