import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/c19data.dart';

import '../providers/covid19.dart';

class C19StateBox extends StatelessWidget {
  String patientState;

  C19StateBox({this.patientState});

  @override
  Widget build(BuildContext context) {
    //   c19 currentState;

    // currentState = patientState
    //     Provider.of<Covid19>(context,listen:true).referenceCovid19SeverityLevelsList.firstWhere((element) => element.abbrv == currentState.abbrv);

    var selectedCovidState = Provider.of<Covid19>(context, listen: true)
        .referenceCovid19SeverityLevelsList
        .firstWhere((element) => element.abbrv == patientState);
    return selectedCovidState.index < 1
        ? Container()
        : Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: selectedCovidState.stateColor,
                  width: 3,
                )),
            child: Center(
              child: Text(
                selectedCovidState.abbrv.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          );
  }
}
