import './patient_vitals/consciousness.dart';
import './patient_vitals/fi02.dart';
import './patient_vitals/flowrate.dart';
import './patient_vitals/mode.dart';
import './patient_vitals/periphery.dart';
import './patient_vitals/position.dart';
import './patient_vitals/rhythm.dart';
import './patient_vitals/oxygenDelivery.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientNote {
  String id;
  DateTime timestamp;
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

  PatientNote({
    this.id,
    this.abdomen,
    this.admittedWith,
    this.cns,
    this.complications,
    this.cvs,
    this.diagnosis,
    this.examination,
    this.family,
    this.hematology,
    this.idtext,
    this.impression,
    this.issues,
    this.lines,
    this.plan,
    this.premorbids,
    this.renal,
    this.resp,
    this.timestamp,
  });

  getDisplayName(String key) {
    switch (key) {
      case 'premorbids':
        {
          return 'Pre Morbidities';
        }
        break;
      case 'abdomen':
        {
          return 'Abdomen';
        }
        break;
      case 'admittedWith':
        {
          return 'Admitted With';
        }
        break;
      case 'cns':
        {
          return 'CNS';
        }
        break;
      case 'cvs':
        {
          return 'CVS';
        }
        break;
      case 'resp':
        {
          return 'Respiration';
        }
        break;
      case 'renal':
        {
          return 'Renal';
        }
        break;
      case 'hematology':
        {
          return 'Hematology';
        }
        break;
      case 'idtext':
        {
          return 'ID';
        }
        break;
      case 'lines':
        {
          return 'Lines';
        }
        break;
      case 'complications':
        {
          return 'Complications if any';
        }
        break;
      case 'examination':
        {
          return 'Orthopedic/ ENT/ Ophthal/ Dermat/ Regional examination issue if any';
        }
        break;
      case 'impression':
        {
          return 'Impression';
        }
        break;
      case 'diagnosis':
        {
          return 'Diagnosis';
        }
        break;
      case 'issues':
        {
          return 'Issues';
        }
        break;
      case 'family':
        {
          return 'Family';
        }
        break;
      case 'plan':
        {
          return 'Plan';
        }
        break;
    }
  }

  PatientNote.fromMap(Map data)
      : this(
          id: data['id'],
          abdomen: data['abdomen'],
          admittedWith: data['admittedWidth'],
          cns: data['cns'],
          complications: data['complications'],
          cvs: data['cvs'],
          diagnosis: data['diagnosis'],
          examination: data['examination'],
          family: data['family'],
          hematology: data['hematology'],
          idtext: data['idtext'],
          impression: data['impression'],
          issues: data['issues'],
          lines: data['lines'],
          plan: data['plan'],
          premorbids: data['premorbids'],
          renal: data['renal'],
          resp: data['resp'],
          timestamp: data['timestamp'].toDate(),
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': Timestamp.fromDate(timestamp),
      'abdomen': abdomen,
      'admittedWith': admittedWith,
      'cns': cns,
      'complications': complications,
      'cvs': cvs,
      'diagnosis': diagnosis,
      'examination': examination,
      'family': family,
      'hematology': hematology,
      'idtext': idtext,
      'impression': impression,
      'issues': issues,
      'lines': lines,
      'plan': plan,
      'premorbids': premorbids,
      'renal': renal,
      'resp': resp,
    };
  }
}
