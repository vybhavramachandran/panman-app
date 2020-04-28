import 'package:cloud_firestore/cloud_firestore.dart';

import './patient_vitals/consciousness.dart';
import './patient_vitals/fi02.dart';
import './patient_vitals/flowrate.dart';
import './patient_vitals/mode.dart';
import './patient_vitals/periphery.dart';
import './patient_vitals/position.dart';
import './patient_vitals/rhythm.dart';
import './patient_vitals/oxygenDelivery.dart';

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
  String oxygenPerMin;
  OxygenDelivery oxygenDeliverySelection;
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
  String airvoFi02;
  FlowRate airvoFlowRate;
  String fi02ventilator;
  FlowRate ventilatorFlowrate;
  String peepepap;
  String psipap;
  String tv;

  PatientVital(
      {this.id,
      this.timestamp,
      this.airvoFi02,
      this.airvoFlowRate,
      this.consciousness,
      this.dbp,
      this.etc02,
      this.event,
      this.fi02,
      this.oxygenDeliverySelection,
      this.oxygenPerMin,
      this.fi02ventilator,
      this.ventilatorFlowrate,
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
          timestamp: data['timestamp'].toDate(),
          airvoFi02: data['airvoFi02'],
          airvoFlowRate: data['airvoFlowRate'] != ""
              ? FlowRate.fromMap(data['airvoFlowRate'])
              : null,
          consciousness: data['consciousness'] != ""
              ? Consciousness.fromMap(data['consciousness'])
              : null,
          dbp: data['dbp'],
          etc02: data['etc02'],
          event: data['event'],
          //   fi02: data['fi02'] != "" ? Fi02.fromMap(data['fi02']) : null,
          oxygenPerMin: data['oxygenPerMin'],
          oxygenDeliverySelection: data['oxygenDeliverySelection'] != ""
              ? OxygenDelivery.fromMap(data['oxygenDeliverySelection'])
              : null,
          fi02ventilator: data['fi02ventilator'],
          ventilatorFlowrate: data['ventilatorFlowrate'] != ""
              ? FlowRate.fromMap(data['ventilatorFlowrate'])
              : null,
          gcs_e: data['gcs_e'],
          gcs_m: data['gcs_m'],
          gcs_v: data['gcs_v'],
          grbs: data['grbs'],
          hr: data['hr'],
          left_pupil: data['left_pupil'],
          right_pupil: data['right_pupil'],
          mode: data['mode'] != "" ? Mode.fromMap(data['mode']) : null,
          peep: data['peep'],
          peepepap: data['peepepap'],
          periphery: data['periphery'] != ""
              ? Periphery.fromMap(data['periphery'])
              : null,
          position: data['position'] != ""
              ? Position.fromMap(data['position'])
              : null,
          ppeak: data['ppeak'],
          psipap: data['psipap'],
          rhythm: data['rhythm'] != "" ? Rhythm.fromMap(data['rhythm']) : null,
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
  getDisplayName(String key) {
    switch (key) {
      case 'event':
        {
          return 'Recorded Event';
        }
        break;
      case 'gcs_e':
        {
          return 'GCS-E';
        }
        break;
      case 'gcs_v':
        {
          return 'GCS-V';
        }
        break;
      case 'gcs_m':
        {
          return 'GCS-M';
        }
        break;
      case 'left_pupil':
        {
          return 'Left Pupil';
        }
        break;
      case 'right_pupil':
        {
          return 'Right Pupil';
        }
        break;
      case 'consciousness':
        {
          return 'Consciousness';
        }
        break;
      case 'rhythm':
        {
          return 'Rhythm';
        }
        break;
      case 'hr':
        {
          return 'HR';
        }
        break;
      case 'sbp':
        {
          return 'SBP';
        }
        break;
      case 'dbp':
        {
          return 'DBP';
        }
        break;
      case 'periphery':
        {
          return 'Periphery';
        }
        break;
      case 'rr':
        {
          return 'RR';
        }
        break;
      case 'sp02':
        {
          return 'SP02';
        }
        break;
      case 'fi02':
        {
          return 'FI02';
        }
        break;
      case 'oxygenPerMin':
        {
          return 'Oxygen Flow Per Minute';
        }
        break;
      case 'oxygenDeliverySelection':
        {
          return 'Oxygen Delivery Device';
        }
        break;
      case 'sputum_white':
        {
          return 'Sputum Quantity - White Color';
        }
        break;
      case 'sputum_yellow':
        {
          return 'Sputum Quantity - Yellow Color';
        }
        break;
      case 'sputum_red':
        {
          return 'Sputum Quantity - Red Color';
        }
        break;
      case 'sputum_green':
        {
          return 'Sputum Quantity - Green Color';
        }
        break;
      case 'sputum_other':
        {
          return 'Sputum Quantity - Other Colors';
        }
        break;
      case 'etc02':
        {
          return 'EtCO2';
        }
        break;
      case 'temperature':
        {
          return 'Temperature';
        }
        break;
      case 'grbs':
        {
          return 'GRBS';
        }
        break;
      case 'urineOutput':
        {
          return 'Urine Output';
        }
        break;
      case 'position':
        {
          return 'Position';
        }
        break;
      case 'rrsetactual':
        {
          return 'RR Set/Actual';
        }
        break;
      case 'mode':
        {
          return 'Mode';
        }
        break;
      case 'peep':
        {
          return 'Peep';
        }
        break;
      case 'tve':
        {
          return 'TVe';
        }
        break;
      case 'ppeak':
        {
          return 'P Peak';
        }
        break;
      case 'fi02ventilator':
        {
          return 'Fi02 - Ventilator';
        }
        break;
      case 'ventilatorFlowrate':
        {
          return 'Ventilator Flow Rate';
        }
        break;
      case 'peepepap':
        {
          return 'PEEP/EPAP';
        }
        break;
      case 'psipap':
        {
          return 'PS/IPAP';
        }
        break;
      case 'tv':
        {
          return 'TV';
        }
        break;
      case 'airvoFi02':
        {
          return 'AIRVO Fi02';
        }
        break;
      case 'airvoFlowRate':
        {
          return 'AIRVO Flow Rate';
        }
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': Timestamp.fromDate(timestamp),
      'event': event != null ? event : "",
      'gcs_e': gcs_e != null ? gcs_e : "",
      'gcs_m': gcs_m != null ? gcs_m : "",
      'gcs_v': gcs_v != null ? gcs_v : "",
      'left_pupil': left_pupil != null ? left_pupil : "",
      'right_pupil': right_pupil != null ? right_pupil : "",
      'consciousness': consciousness != null ? consciousness.toMap() : "",
      'rhythm': rhythm != null ? rhythm.toMap() : "",
      'hr': hr != null ? hr : "",
      'sbp': sbp != null ? sbp : "",
      'dbp': dbp != null ? dbp : "",
      'periphery': periphery != null ? periphery.toMap() : "",
      'rr': rr != null ? rr : "",
      'sp02': sp02 != null ? sp02 : "",
      'oxygenPerMin': oxygenPerMin != null ? oxygenPerMin : "",
      'oxygenDeliverySelection': oxygenDeliverySelection != null
          ? oxygenDeliverySelection.toMap()
          : "",
      'sputum_green': sputum_green != null ? sputum_green : "",
      'sputum_other': sputum_other != null ? sputum_other : "",
      'sputum_red': sputum_red != null ? sputum_red : "",
      'sputum_white': sputum_white != null ? sputum_white : "",
      'sputum_yellow': sputum_yellow != null ? sputum_yellow : "",
      'etc02': etc02 != null ? etc02 : "",
      'temperature': temperature != null ? temperature : "",
      'grbs': grbs != null ? grbs : "",
      'urineOutput': urineOutput != null ? urineOutput : "",
      'position': position != null ? position.toMap() : "",
      'rrsetactual': rrsetactual != null ? rrsetactual : "",
      'mode': mode != null ? mode.toMap() : "",
      'peep': peep != null ? peep : "",
      'tve': tve != null ? tve : "",
      'ppeak': ppeak != null ? ppeak : "",

      'airvoFi02': airvoFi02 != null ? airvoFi02 : "",
      'airvoFlowRate': airvoFlowRate != null ? airvoFlowRate.toMap() : "",
      // 'fi02': fi02 != null ? fi02.toMap() : "",
      'fi02ventilator': fi02ventilator != null ? fi02ventilator : "",
      'ventilatorFlowrate':
          ventilatorFlowrate != null ? ventilatorFlowrate.toMap() : "",
      'peepepap': peepepap != null ? peepepap : "",
      'psipap': psipap != null ? psipap : "",
      'tv': tv != null ? tv : "",
    };
  }
}
