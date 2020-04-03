import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

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

    String fetchCardName(String id){
      var fetchedElement = Provider.of<Hospitals>(context,listen:false).referenceMedicalSupplyList.singleWhere((element) => element.id==id);
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
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: Provider.of<Hospitals>(context,
                                          listen: false)
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

                                  // Flexible(
                                  //     flex: 2,
                                  //     child: medicalSuplyGraphWidget(
                                  //       medicalSupplyName: "N95 Mask",
                                  //       quantityLeft: 200,
                                  //       willLastForInDays: 5,
                                  //     )),
                                  // Flexible(
                                  //     flex: 2,
                                  //     child: medicalSuplyGraphWidget(
                                  //       medicalSupplyName: "Goggles",
                                  //       quantityLeft: 50,
                                  //       willLastForInDays: 10,
                                  //     )),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                        flex: 2,
                                        child: medicalSuplyGraphWidget(
                                          medicalSupplyName: "Apron",
                                          quantityLeft: 10,
                                          willLastForInDays: 2,
                                        )),
                                    Flexible(
                                        flex: 2,
                                        child: medicalSuplyGraphWidget(
                                          medicalSupplyName: "Head Cover",
                                          quantityLeft: 600,
                                          willLastForInDays: 20,
                                        )),
                                    Flexible(
                                        flex: 2,
                                        child: medicalSuplyGraphWidget(
                                          medicalSupplyName: "Shoe Cover",
                                          quantityLeft: 400,
                                          willLastForInDays: 30,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.cyan,
                      ),
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
