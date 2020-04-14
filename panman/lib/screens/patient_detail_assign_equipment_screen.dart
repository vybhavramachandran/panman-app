import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panman/providers/hospital.dart';
import 'package:provider/provider.dart';

import '../widgets/patient_detailed_header.dart';

import '../providers/patients.dart';

class PatientDetailAssignEquipment extends StatefulWidget {
  static const routeName = '/patient_detail_assign_equipment_screen';

  @override
  _PatientDetailAssignEquipmentState createState() =>
      _PatientDetailAssignEquipmentState();
}

class _PatientDetailAssignEquipmentState
    extends State<PatientDetailAssignEquipment> {
  bool setOnce = false;
  bool ventilatorCheck = false;
  bool showConfirmButton = false;
  bool isUpdating = false;

  void onChanged(bool value) {
    setState(() {
      showConfirmButton = true;
      ventilatorCheck = value;
      print(ventilatorCheck);
    });
  }

  equipmentCard(
      {String abbrv, String fullText, Color cardColor, int optionNo}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Checkbox(
                  value: ventilatorCheck,
                  onChanged: Provider.of<Hospitals>(context, listen: true)
                                  .getVentilatorCount() ==
                              0 &&
                          ventilatorCheck == false
                      ? null
                      : onChanged,
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  fullText,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              // Flexible(
              //   flex: 5,
              //   child: Text(
              //     "${Provider.of<Hospitals>(context, listen: true).getVentilatorCount().toString()} remaining",
              //     style: Theme.of(context).textTheme.bodyText2,
              //   ),
              // ),
              Flexible(
                flex: 1,
                child: FaIcon(
                  FontAwesomeIcons.infoCircle,
                  size: 15,
                ),
              ),
            ],
          ),
        ));
  }

  bool _isLoading;
  Future fetchFuture;

  initState() {
    fetchFuture = refreshHospitalDetails(context);
  }

  Future refreshHospitalDetails(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Hospitals>(context, listen: false)
        .getHospitalDetailsFromServer(
            Provider.of<Hospitals>(context, listen: false).fetchedHospital.id);
    setState(() {
      _isLoading = false;
    });
    // await Provider.of<Appointments>(context, listen: false)
    //     .fetchAppointmentsFromFirebase();

    print("refreshHospitalCalled called");
    // setState(() {
    //   _isLoading = false;
    //   // appointments = Provider.of<Appointments>(context, listen: false)
    //   //     .fetchedAppointmentList;
    // });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (setOnce == false) {
      this.ventilatorCheck = Provider.of<Patients>(context, listen: true)
          .selectedPatient
          .ventilatorUsed;
      setOnce = true;
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "PATIENT / EQUIPMENT",
              style: Theme.of(context).textTheme.caption,
            ),
            centerTitle: true,
            flexibleSpace: PatientDetailedHeader(
              textColor: Colors.white,
              headerPatient:
                  Provider.of<Patients>(context, listen: true).selectedPatient,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshHospitalDetails(context),
          child: Container(
            child: _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          equipmentCard(
                            abbrv: "Ven",
                            fullText: "Ventilator",
                            cardColor: Colors.green,
                            optionNo: 1,
                          ),
                        ],
                      ),
                      showConfirmButton == true
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: Theme.of(context).accentColor,
                                  child: isUpdating == true
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white)
                                      : Text(
                                          "CHANGE STATE",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                  onPressed: () async {
                                    setState(() {
                                      isUpdating = true;
                                    });
                                    var result = await Provider.of<Patients>(
                                            context,
                                            listen: false)
                                        .toggleVentilatorAssignment(
                                            ventilatorCheck);
                                    if (result == true) {
                                      setState(() {
                                        isUpdating = false;
                                        showConfirmButton = false;
                                        Navigator.of(context).pop();
                                      });
                                    } else {
                                      setState(() {
                                        ventilatorCheck != ventilatorCheck;
                                      });
                                    }
                                  },
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
