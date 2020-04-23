import 'package:flutter/material.dart';
import 'package:panman/models/patientVital.dart';
import 'package:panman/models/patient_vitals/oxygenDelivery.dart';
import 'package:provider/provider.dart';

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

import '../widgets/patient_detailed_header.dart';

import '../models/patient.dart';
import '../models/patient_vitals/consciousness.dart';
import '../models/patient_vitals/fi02.dart';
import '../models/patient_vitals/flowrate.dart';
import '../models/patient_vitals/mode.dart';
import '../models/patient_vitals/periphery.dart';
import '../models/patient_vitals/rhythm.dart';
import '../models/patient_vitals/position.dart';

import '../providers/patients.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class PatientVitalsAddScreen extends StatefulWidget {
  static const routeName = '/patient_vitals_add_screen';
  @override
  _PatientVitalsAddScreenState createState() => _PatientVitalsAddScreenState();
}

class _PatientVitalsAddScreenState extends State<PatientVitalsAddScreen> {
  var textFocusField = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool showConfirmButton = true;
  var formKey = new GlobalKey<FormState>();

  var eventController = new TextEditingController();

  String event;
  String left_pupil;
  String right_pupil;
  String hr;
  String sbp;
  String dbp;
  String rr;
  String sp02;
  String etc02;
  String temperature;
  String grbs;
  String urineOutput;
  String rrsetactual;
  String peep;
  String tve;
  String ppeak;
  String airvo;
  String peepepap;
  String psipap;
  String tv;
  String oxygen;
  String gcs_e;
  String gcs_v;
  String gcs_m;
  String sputum_white;
  String sputum_yellow;
  String sputum_red;
  String sputum_green;
  String sputum_other;

  var consciousnessGroupValue;
  var rhythmGroupValue;
  var peripheryGroupValue;
  var fi02GroupValue;
  var fi02VentilatorGroupValue;
  var oxygenDeliveryGroupValue;
  var positionGroupValue;
  var modeGroupValue;
  var flowRateGroupValue;

  consciousnessRadioTapped(int value) {
    setState(() {
      consciousnessGroupValue = value;
    });
  }

  rhythmRadioTapped(int value) {
    setState(() {
      rhythmGroupValue = value;
    });
  }

  peripheryRadioTapped(int value) {
    setState(() {
      peripheryGroupValue = value;
    });
  }

  fi02RadioTrapped(int value) {
    setState(() {
      fi02GroupValue = value;
    });
  }

  fi02VentilatorRadioTapped(int value) {
    setState(() {
      fi02VentilatorGroupValue = value;
    });
  }

  oxygeDeliveryRadioTapped(int value) {
    setState(() {
      oxygenDeliveryGroupValue = value;
    });
  }

  positionRadioTapped(int value) {
    setState(() {
      positionGroupValue = value;
    });
  }

  modeRadioTapped(int value) {
    setState(() {
      modeGroupValue = value;
    });
  }

  flowRateRadioTapped(int value) {
    setState(() {
      flowRateGroupValue = value;
    });
  }

  returnSectionSeparator(String sectionName) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Text(sectionName,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black54)),
    );
  }

  GCSSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("GCS",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text(
                "Make Entry in all Primary Brain problems,  Other patients only if asked to monitor. Use AVPU for other pt.",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "E",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                      DropdownButton<String>(
                        value: gcs_e,
                        hint: Text("Select"),
                        items: <String>['1', '2', '3', '4', '5', '6']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            gcs_e = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "V",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                      DropdownButton<String>(
                        value: gcs_v,
                        hint: Text("Select"),
                        items: <String>['1', '2', '3', '4', '5', '6']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            gcs_v = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "M",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                      DropdownButton<String>(
                        value: gcs_m,
                        hint: Text("Select"),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.black),
                        items: <String>['1', '2', '3', '4', '5', '6']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            gcs_m = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PupilSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Pupil",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("mm +/- format. Eg 2+, 3-",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black),
                            labelText: "Left",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            setState(() {
                              left_pupil = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black),
                            labelText: "Right",
                            // hintText: "Event",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300])),
                          ),
                          onSaved: (String value) {
                            setState(() {
                              right_pupil = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ConsciousnessSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Consciousness",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("If monitoring GCS, do not fill this",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: consciousnessGroupValue,
                        onChanged: (value) => consciousnessRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Alert",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: consciousnessGroupValue,
                        onChanged: (value) => consciousnessRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Verbal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: consciousnessGroupValue,
                        onChanged: (value) => consciousnessRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Pain",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: consciousnessGroupValue,
                        onChanged: (value) => consciousnessRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Unresponsive",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // CVSSection() {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text("CVS",
  //               style: Theme.of(context).textTheme.headline6.copyWith(
  //                   fontWeight: FontWeight.bold, color: Colors.black54)),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           TextFormField(
  //             validator: (value) {
  //               if (value.isEmpty) {
  //                 return 'Please enter some text';
  //               }
  //               return null;
  //             },
  //             style: Theme.of(context).textTheme.bodyText1,
  //             decoration: InputDecoration(
  //               labelStyle: Theme.of(context)
  //                   .textTheme
  //                   .bodyText1
  //                   .copyWith(color: Colors.black),
  //               labelText: "CVS",
  //               // hintText: "Event",
  //               enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.grey[300])),
  //               focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.grey[300])),
  //             ),
  //             onSaved: (String value) {},
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  RhythmSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Rhythm",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Sinus",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "AF",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Atrial Flutter",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "VT",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "VF",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: rhythmGroupValue,
                        onChanged: (value) => rhythmRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Junctional Rhythm",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  HRSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("HR",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "HR",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  hr = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  SBPSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("SBP",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "SBP",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  sbp = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  DBPSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("DBP",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "DBP",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  dbp = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  PeripherySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Periphery",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("If periphery blue/ dark , inform Dr.",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: peripheryGroupValue,
                        onChanged: (value) => peripheryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Cold",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: peripheryGroupValue,
                        onChanged: (value) => peripheryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Tepid",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: peripheryGroupValue,
                        onChanged: (value) => peripheryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Warm",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: peripheryGroupValue,
                        onChanged: (value) => peripheryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Hot",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  DividerText(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 5),
      child: Column(
        children: <Widget>[
          SizedBox(height:40),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  RRSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("RR",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "RR",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  rr = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  SP02Section() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Sp02",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Sp02",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  sp02 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  oxygenSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Oxygen",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(height: 10,),
             Text("Flow in litres/minute",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Oxygen L/min",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  oxygen = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  oxygenDeliverySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Oxygen Delivery Device ",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: oxygenDeliveryGroupValue,
                        onChanged: (value) => oxygeDeliveryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Nasal Prongs",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: oxygenDeliveryGroupValue,
                        onChanged: (value) => oxygeDeliveryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Face Mask",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: oxygenDeliveryGroupValue,
                        onChanged: (value) => oxygeDeliveryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Venturi Mask",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: oxygenDeliveryGroupValue,
                        onChanged: (value) => oxygeDeliveryRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "NRBM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FI02Section() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Fi02",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "21 Room Air",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "24 - 1 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "28 - 2 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "32 - 3 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "36 - 4 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "40 - 6 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 6,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "50 - 8 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 7,
                        groupValue: fi02GroupValue,
                        onChanged: (value) => fi02RadioTrapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "60 - 10 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FI02VentilatorSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Fi02-Ventilator",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "21 Room Air",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "24 - 1 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "28 - 2 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "32 - 3 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "36 - 4 L nasal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "40 - 6 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 6,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "50 - 8 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 7,
                        groupValue: fi02VentilatorGroupValue,
                        onChanged: (value) => fi02VentilatorRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "60 - 10 L FM",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ETC02Section() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("EtCo2",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "EtCo2",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  etc02 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  SputumColorQuantitySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Sputum Color Quantity",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "White",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          autofocus: true,
                          value: sputum_white,
                          hint: Text("Select"),
                          items: <String>['Mild', 'Moderate', 'High']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              sputum_white = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Yellow",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          value: sputum_yellow,
                          hint: Text("Select"),
                          items: <String>['Mild', 'Moderate', 'High']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              sputum_yellow = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Red",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          value: sputum_red,
                          hint: Text("Select"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black),
                          items: <String>['Mild', 'Moderate', 'High']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              sputum_red = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Green",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          value: sputum_green,
                          hint: Text("Select"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black),
                          items: <String>['Mild', 'Moderate', 'High']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              sputum_green = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Other",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        DropdownButton<String>(
                          value: sputum_other,
                          hint: Text("Select"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black),
                          items: <String>['Mild', 'Moderate', 'High']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              sputum_other = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TemperatureSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Temperature",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("in F",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Temperature",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  temperature = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  GRBSSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("GRBS",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("in mg/dL",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "GRBS",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  grbs = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  UrineOutputSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Urine Output",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 10,
            ),
            Text("Enter at 00, 04, 08, 12, 16, 20 hrs",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Urine Output",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  urineOutput = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  PositionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Position",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Self Positioning",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Supine, Head Up",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Supine Flat",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Right Lateral",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Left Lateral",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Right Recovery",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 6,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Left Recovery",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 7,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Prone",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 8,
                        groupValue: positionGroupValue,
                        onChanged: (value) => positionRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "Chair/Sofa",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  RRSetActualSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("RR Set/Actual",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "RR Set/Actual",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  rrsetactual = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  PeepSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Peep",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Peep",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  peep = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  TVe() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("TVe",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "TVe",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  tv = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  PPeakSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("P Peak",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "P Peak",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  ppeak = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  AIRVOSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("AIRVO",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "AIRVO",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  airvo = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // NIVSection() {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text("NIV",
  //               style: Theme.of(context).textTheme.headline6.copyWith(
  //                   fontWeight: FontWeight.bold, color: Colors.black54)),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           TextFormField(
  //             validator: (value) {
  //               if (value.isEmpty) {
  //                 return 'Please enter some text';
  //               }
  //               return null;
  //             },
  //             style: Theme.of(context).textTheme.bodyText1,
  //             decoration: InputDecoration(
  //               labelStyle: Theme.of(context)
  //                   .textTheme
  //                   .bodyText1
  //                   .copyWith(color: Colors.black),
  //               labelText: "NIV",
  //               // hintText: "Event",
  //               enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.grey[300])),
  //               focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.grey[300])),
  //             ),
  //             onSaved: (String value) {},
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  PeepEpapSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("PEEP/EPAP",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "Peep/Epap",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  peepepap = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  PSIPAPSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("PS/IPAP",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "PS/IPAP",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  psipap = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  TVSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("TV",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              /*
validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },*/
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black),
                //labelText: "TV",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  tv = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  ModeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mode",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "ASV",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "SIMV VC",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "SIMV PC",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "AC PRVC/ PRVC VG",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "PSV/ PS-CPAP",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: modeGroupValue,
                        onChanged: (value) => modeRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "T Piece",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  FlowRateSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Flow Rate",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "30",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "35",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 2,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "40",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 3,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "45",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "50",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "55",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: 6,
                        groupValue: flowRateGroupValue,
                        onChanged: (value) => flowRateRadioTapped(value),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        "60",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  PatientVitalsAddScreenBody(Patient selectedPatient) {
    var globalKey = new GlobalKey();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //       key: globalKey,
            children: <Widget>[
              DividerText("Record Event"),
              TextFormField(
                //         controller: eventController,
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                style: Theme.of(context).textTheme.bodyText1,

                decoration: InputDecoration(
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black),
                  //labelText: "Event",
                  // hintText: "Event",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300])),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300])),
                ),
                onSaved: (String value) {
                  setState(() {
                    event = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              DividerText("CNS"),
              GCSSection(),
              SizedBox(
                height: 20,
              ),
              PupilSection(),
              ConsciousnessSection(),
              DividerText("CVS"),
              RhythmSection(),
              HRSection(),
              SBPSection(),
              DBPSection(),
              PeripherySection(),
              DividerText("Respiratory System"),
              RRSection(),
              SP02Section(),
              oxygenSection(),
              oxygenDeliverySection(),
           //   FI02Section(),
              SputumColorQuantitySection(),
              ETC02Section(),
              DividerText("Other Parameters"),
              TemperatureSection(),
              GRBSSection(),
              UrineOutputSection(),
              PositionSection(),
              DividerText("Mechanical Ventilation"),
              RRSetActualSection(),
              ModeSection(),
              PeepSection(),
              TVe(),
              PPeakSection(),
              AIRVOSection(),
              FI02VentilatorSection(),
              FlowRateSection(),
              // DividerText("Mechanical Ventilation"),
              PeepEpapSection(),
              PSIPAPSection(),
              TVSection(),
              DividerText("End"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                "PATIENT/VITALS/ADD",
                style: Theme.of(context).textTheme.caption,
              ),
              centerTitle: true,
              flexibleSpace: PatientDetailedHeader(
                textColor: Colors.white,
                headerPatient: Provider.of<Patients>(context, listen: true)
                    .selectedPatient,
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              PatientVitalsAddScreenBody(
                  Provider.of<Patients>(context, listen: true).selectedPatient),
             MediaQuery.of(context).viewInsets.bottom == 0
                  ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child:
                        Provider.of<Patients>(context, listen: true).isUpdating
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white30,
                              )
                            : Text(
                                "SAVE VITALS",
                                style: Theme.of(context).textTheme.caption,
                              ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        await Provider.of<Patients>(context, listen: false)
                            .addVitalMeasurement(PatientVital(
                          event: event,
                          gcs_e: gcs_e,
                          gcs_v: gcs_v,
                          gcs_m: gcs_m,
                          airvo: airvo,
                          consciousness: consciousnessGroupValue != null
                              ? consciousnessLevels[consciousnessGroupValue]
                              : null,
                          dbp: dbp,
                          etc02: etc02,
                          oxygenPerMin: oxygen,
                          oxygenDeliverySelection: oxygenDeliveryGroupValue !=
                                  null
                              ? OxygenDeliveryTypes[oxygenDeliveryGroupValue]
                              : null,
                          // fi02: fi02GroupValue != null
                          //     ? Fi02Levels[fi02GroupValue]
                          //     : null,
                          fi02ventilator: fi02VentilatorGroupValue != null
                              ? Fi02Levels[fi02VentilatorGroupValue]
                              : null,
                          flowrate: flowRateGroupValue != null
                              ? FlowRateLevels[flowRateGroupValue]
                              : null,
                          grbs: grbs,
                          hr: hr,
                          id: randomAlphaNumeric(20),
                          left_pupil: left_pupil,
                          right_pupil: right_pupil,
                          mode: modeGroupValue != null
                              ? ModeLevels[modeGroupValue]
                              : null,
                          peep: peep,
                          peepepap: peepepap,
                          periphery: peripheryGroupValue != null
                              ? PeripheryLevels[peripheryGroupValue]
                              : null,
                          position: positionGroupValue != null
                              ? PositionLevels[positionGroupValue]
                              : null,
                          ppeak: ppeak,
                          psipap: psipap,
                          rhythm: rhythmGroupValue != null
                              ? RhythmLevels[rhythmGroupValue]
                              : null,
                          rr: rr,
                          rrsetactual: rrsetactual,
                          sbp: sbp,
                          sp02: sp02,
                          sputum_green: sputum_green,
                          sputum_other: sputum_other,
                          sputum_white: sputum_white,
                          sputum_red: sputum_red,
                          sputum_yellow: sputum_yellow,
                          temperature: temperature,
                          timestamp: DateTime.now(),
                          tv: tv,
                          tve: tve,
                          urineOutput: urineOutput,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ):Container(),
            ],
          )),
    );
  }
}
