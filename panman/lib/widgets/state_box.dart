import 'package:flutter/material.dart';
import '../models/c19data.dart';

class C19StateBox extends StatelessWidget {
  C19PatientState patientState;

  C19StateBox({this.patientState});

  @override
  Widget build(BuildContext context) {
    c19 currentState;

    currentState =
        c19states.firstWhere((element) => element.state == patientState);

    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white70,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: currentState.stateColor,
            width: 3,
          )),
      child: Center(
        child: Text(
          currentState.abbrv.toString(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
