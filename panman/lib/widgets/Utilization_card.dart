import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:panman/models/equipment.dart';

import 'package:provider/provider.dart';

import '../models/medicalSupply.dart';
import './graphs/medical_supply_graph_widget.dart';

import '../providers/hospital.dart';
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END

class UtilizationCard extends StatelessWidget {
  String title;
  Color backgroundColor;

  UtilizationCard({this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    String fetchCardName(String id) {
      var fetchedElement = Provider.of<Hospitals>(context, listen: false)
          .referenceMedicalSupplyList
          .singleWhere((element) => element.id == id);
      return fetchedElement.name;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  PageView(
                    controller: pageController,
                    children: <Widget>[
                      Container(
                        //    padding: EdgeInsets.all(5),
                        // color: Colors.pink,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children:
                              Provider.of<Hospitals>(context, listen: false)
                                  .fetchedHospital
                                  .medicalSupplies
                                  .map((item) {
                            return Flexible(
                                flex: 2,
                                child: medicalSuplyGraphWidget(
                                  medicalSupplyName: fetchCardName(item.id),
                                  quantityLeft: item.qty,
                                  willLastForInDays: 10,
                                ));
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.cyan,
                          child: medicalSuplyGraphWidget(
                            medicalSupplyName: "Ventilators",
                            quantityLeft:
                                Provider.of<Hospitals>(context, listen: false)
                                    .fetchedHospital
                                    .equipments[0]
                                    .qty,
                            willLastForInDays: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: new DotsIndicator(
                  //     dotsCount: 2,
                  //     position: pageController.page,
                  //     decorator: DotsDecorator(
                  //       size: const Size.square(9.0),
                  //       activeSize: const Size(18.0, 9.0),
                  //       activeShape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(5.0)),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
