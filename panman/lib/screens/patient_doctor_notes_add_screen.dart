import 'package:flutter/material.dart';
import 'package:panman/models/patientNote.dart';
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

class PatientDoctorNotesAddScreen extends StatefulWidget {
  static const routeName = '/patient_doctor_notes_add_screen';
  @override
  _PatientDoctorNotesAddScreenState createState() =>
      _PatientDoctorNotesAddScreenState();
}

class _PatientDoctorNotesAddScreenState
    extends State<PatientDoctorNotesAddScreen> {
  var formKey = new GlobalKey<FormState>();

  String premorbids;
  String admittedWith;
  String cns;
  String cvs;
  String resp;
  String abdomen;
  String renal;
  String hematology;
  String idtext;
  String lines;
  String complications;
  String examination;
  String impression;
  String diagnosis;
  String issues;
  String family;
  String plan;

  FocusNode premorbidsFocusNode;
  FocusNode admittedWithFocusNode;
  FocusNode cnsFocusNode;
  FocusNode cvsFocusNode;
  FocusNode respFocusNode;
  FocusNode abdomenFocusNode;
  FocusNode renalFocusNode;
  FocusNode hematologyFocusNode;
  FocusNode idFocusNode;
  FocusNode linesFocusNode;
  FocusNode complicationsFocusNode;
  FocusNode examinationFocusNode;
  FocusNode impressionFocusNode;
  FocusNode diagnosisFocusNode;
  FocusNode issuesFocusNode;
  FocusNode familyFocusNode;
  FocusNode planFocusNode;

  initState() {
    super.initState();
    premorbidsFocusNode = FocusNode();
    admittedWithFocusNode = FocusNode();
    cnsFocusNode = FocusNode();
    cvsFocusNode = FocusNode();
    respFocusNode = FocusNode();
    abdomenFocusNode = FocusNode();
    renalFocusNode = FocusNode();
    hematologyFocusNode = FocusNode();
    idFocusNode = FocusNode();
    linesFocusNode = FocusNode();
    complicationsFocusNode = FocusNode();
    examinationFocusNode = FocusNode();
    impressionFocusNode = FocusNode();
    diagnosisFocusNode = FocusNode();
    issuesFocusNode = FocusNode();
    familyFocusNode = FocusNode();
    planFocusNode = FocusNode();
  }

  dispose() {
    super.dispose();
    premorbidsFocusNode.dispose();
    admittedWithFocusNode.dispose();
    cnsFocusNode.dispose();
    cvsFocusNode.dispose();
    respFocusNode.dispose();
    abdomenFocusNode.dispose();
    renalFocusNode.dispose();
    hematologyFocusNode.dispose();
    idFocusNode.dispose();
    linesFocusNode.dispose();
    complicationsFocusNode.dispose();
    examinationFocusNode.dispose();
    impressionFocusNode.dispose();
    diagnosisFocusNode.dispose();
    issuesFocusNode.dispose();
    familyFocusNode.dispose();
    planFocusNode.dispose();
  }

  PatientDoctorNotesAddScreenBody(Patient selectedPatient) {
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
              Premorbids(),
              admittedWithFunction(),
              CNS(),
              cvsFunction(),
              respFunction(),
              abdomenFunction(),
              renalFunction(),
              hematologyFunction(),
              idFunction(),
              linesFunction(),
              complicationsFunction(),
              examinationFunction(),
              impressionFunction(),
              diagnosisFunction(),
              issuesFunction(),
              familyFunction(),
              planFunction(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Premorbids() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Premorbids",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //  autofocus: true,
              focusNode: premorbidsFocusNode,
              onFieldSubmitted: (v) {
                admittedWithFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Premorbids",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  premorbids = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  admittedWithFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Admitted With",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: admittedWithFocusNode,
              onFieldSubmitted: (v) {
                cnsFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Admitted With",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  admittedWith = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  CNS() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("CNS",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: cnsFocusNode,
              onFieldSubmitted: (v) {
                cvsFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "CNS",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  cns = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  cvsFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("CVS",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: cvsFocusNode,
              onFieldSubmitted: (v) {
                respFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "CVS",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  cvs = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  respFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Resp.",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: respFocusNode,
              onFieldSubmitted: (v) {
                abdomenFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Resp.",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  resp = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  abdomenFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Abdomen",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: abdomenFocusNode,
              onFieldSubmitted: (v) {
                renalFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Abdomen",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  abdomen = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  renalFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Renal",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: renalFocusNode,
              onFieldSubmitted: (v) {
                hematologyFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Renal",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  renal = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  hematologyFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hematology",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: hematologyFocusNode,
              onFieldSubmitted: (v) {
                idFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Hematology",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  hematology = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  idFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("ID",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: idFocusNode,
              onFieldSubmitted: (v) {
                linesFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "ID",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  idtext = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  linesFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Lines",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: linesFocusNode,
              onFieldSubmitted: (v) {
                complicationsFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Lines",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  lines = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  complicationsFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Complications if any",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: complicationsFocusNode,
              onFieldSubmitted: (v) {
                examinationFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Complications if any",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  complications = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  examinationFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Orthopedic/ ENT/ Ophthal/ Dermat/ Regional examination issue",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: examinationFocusNode,
              onFieldSubmitted: (v) {
                impressionFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Issue",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  examination = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  impressionFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Impression",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: impressionFocusNode,
              onFieldSubmitted: (v) {
                diagnosisFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Impression",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  impression = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  diagnosisFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Diagnosis",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: diagnosisFocusNode,
              onFieldSubmitted: (v) {
                issuesFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Diagnosis",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  diagnosis = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  issuesFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Issues",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: issuesFocusNode,
              onFieldSubmitted: (v) {
                familyFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Issues",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  issues = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  familyFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Family",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: familyFocusNode,
              onFieldSubmitted: (v) {
                planFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
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
                //labelText: "Family",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  family = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  planFunction() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Plan",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: planFocusNode,

              textInputAction: TextInputAction.done,
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
                //labelText: "Plan",
                // hintText: "Event",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300])),
              ),
              onSaved: (String value) {
                setState(() {
                  plan = value;
                });
              },
            ),
          ],
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
                "PATIENT / DOCTOR NOTES / ADD",
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
              PatientDoctorNotesAddScreenBody(
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
                          child: Provider.of<Patients>(context, listen: true)
                                  .isUpdating
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white30,
                                )
                              : Text(
                                  "SAVE NOTE",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                          onPressed: () async {
                            formKey.currentState.save();
                            await Provider.of<Patients>(context, listen: false)
                                .addDoctorNote(PatientNote(
                              id: randomAlphaNumeric(20),
                              timestamp: DateTime.now(),
                              abdomen: abdomen,
                              admittedWith: admittedWith,
                              cns: cns,
                              complications: complications,
                              cvs: cvs,
                              diagnosis: diagnosis,
                              examination: examination,
                              family: family,
                              hematology: hematology,
                              idtext: idtext,
                              impression: impression,
                              issues: issues,
                              lines: lines,
                              plan: plan,
                              premorbids: premorbids,
                              renal: renal,
                              resp: resp,
                            ));
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
