import 'package:cloud_firestore/cloud_firestore.dart';

import './patient_vitals/consciousness.dart';
import './patient_vitals/fi02.dart';
import './patient_vitals/flowrate.dart';
import './patient_vitals/mode.dart';
import './patient_vitals/periphery.dart';
import './patient_vitals/position.dart';
import './patient_vitals/rhythm.dart';

class PatientVital {
  String id;
  DateTime timestamp;
  String event;
  String gcs_e;
  String gcs_v;
  String gcs_m;
  String left_pupil;
  String right_pupil;
  Consciousness consciousness;
  Rhythm rhythm;
  String hr;
  String sbp;
  String dbp;
  Periphery periphery;
  String rr;
  String sp02;
  Fi02 fi02;
  String sputum_white;
  String sputum_yellow;
  String sputum_red;
  String sputum_green;
  String sputum_other;
  String etc02;
  String temperature;
  String grbs;
  String urineOutput;
  Position position;
  String rrsetactual;
  Mode mode;
  String peep;
  String tve;
  String ppeak;
  String airvo;
  Fi02 fi02ventilator;
  FlowRate flowrate;
  String peepepap;
  String psipap;
  String tv;

  PatientVital(
      {this.id,
      this.timestamp,
      this.airvo,
      this.consciousness,
      this.dbp,
      this.etc02,
      this.event,
      this.fi02,
      this.fi02ventilator,
      this.flowrate,
      this.gcs_e,
      this.gcs_m,
      this.gcs_v,
      this.grbs,
      this.hr,
      this.left_pupil,
      this.mode,
      this.peep,
      this.peepepap,
      this.periphery,
      this.position,
      this.ppeak,
      this.psipap,
      this.rhythm,
      this.right_pupil,
      this.rr,
      this.rrsetactual,
      this.sbp,
      this.sp02,
      this.sputum_green,
      this.sputum_other,
      this.sputum_red,
      this.sputum_white,
      this.sputum_yellow,
      this.temperature,
      this.tv,
      this.tve,
      this.urineOutput});

  PatientVital.fromMap(Map data)
      : this(
          id: data['id'],
          timestamp: DateTime.parse(data['timestamp']),
          airvo: data['airvo'],
          consciousness: data['consciousness'] != ""
              ? Consciousness.fromMap(data['consciousness'])
              : null,
          dbp: data['dbp'],
          etc02: data['etc02'],
          event: data['event'],
          fi02: data['fi02'] != "" ? Fi02.fromMap(data['fi02']) : null,
          fi02ventilator: data['fi02ventilator'] != ""
              ? Fi02.fromMap(data['fi02ventilator'])
              : null,
          flowrate: data['flowrate'] != ""
              ? FlowRate.fromMap(data['flowrate'])
              : null,
          gcs_e: data['gcs_e'],
          gcs_m: data['gcs_m'],
          gcs_v: data['gcs_v'],
          grbs: data['grbs'],
          hr: data['hr'],
          left_pupil: data['left_pupil'],
          mode: data['mode']!=""?Mode.fromMap(data['mode']):null,
          peep: data['peep'],
          peepepap: data['peepepap'],
          periphery: data['periphery']!=""?Periphery.fromMap(data['periphery']):null,
          position: data['position']!=""?Position.fromMap(data['position']):null,
          ppeak: data['ppeak'],
          psipap: data['psipap'],
          rhythm: data['rhythm']!=""?Rhythm.fromMap(data['rhythm']):null,
          right_pupil: data['right_pupil'],
          rr: data['rr'],
          rrsetactual: data['rrsetactual'],
          sbp: data['sbp'],
          sp02: data['sp02'],
          sputum_green: data['sputum_green'],
          sputum_other: data['sputum_other'],
          sputum_red: data['sputum_red'],
          sputum_white: data['sputum_white'],
          sputum_yellow: data['sputum_yellow'],
          temperature: data['temperature'],
          tv: data['tv'],
          tve: data['tve'],
          urineOutput: data['urineOutput'],
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toString(),
      'airvo': airvo != null ? airvo : "",
      'consciousness': consciousness != null ? consciousness.toMap() : "",
      'dbp': dbp != null ? dbp : "",
      'etc02': etc02 != null ? etc02 : "",
      'event': event != null ? event : "",
      'fi02': fi02 != null ? fi02.toMap() : "",
      'fi02ventilator': fi02ventilator != null ? fi02ventilator.toMap() : "",
      'flowrate': flowrate != null ? flowrate.toMap() : "",
      'gcs_e': gcs_e != null ? gcs_e : "",
      'gcs_m': gcs_m != null ? gcs_m : "",
      'gcs_v': gcs_v != null ? gcs_v : "",
      'grbs': grbs != null ? grbs : "",
      'hr': hr != null ? hr : "",
      'left_pupil': left_pupil != null ? left_pupil : "",
      'mode': mode != null ? mode.toMap() : "",
      'peep': peep != null ? peep : "",
      'peepepap': peepepap != null ? peepepap : "",
      'periphery': periphery != null ? periphery.toMap() : "",
      'position': position != null ? position.toMap() : "",
      'ppeak': ppeak != null ? ppeak : "",
      'psipap': psipap != null ? psipap : "",
      'rhythm': rhythm != null ? rhythm.toMap() : "",
      'right_pupil': right_pupil != null ? right_pupil : "",
      'rr': rr != null ? rr : "",
      'rrsetactual': rrsetactual != null ? rrsetactual : "",
      'sbp': sbp != null ? sbp : "",
      'sp02': sp02 != null ? sp02 : "",
      'sputum_green': sputum_green != null ? sputum_green : "",
      'sputum_other': sputum_other != null ? sputum_other : "",
      'sputum_red': sputum_red != null ? sputum_red : "",
      'sputum_white': sputum_white != null ? sputum_white : "",
      'sputum_yellow': sputum_yellow != null ? sputum_yellow : "",
      'temperature': temperature != null ? temperature : "",
      'tv': tv != null ? tv : "",
      'tve': tve != null ? tve : "",
      'urineOutput': urineOutput != null ? urineOutput : "",
    };
  }
}
