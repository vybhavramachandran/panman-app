import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

import './patient_summary_widget.dart';

class HomePagePatientsWidget extends StatefulWidget {
  @override
  _HomePagePatientsWidgetState createState() => _HomePagePatientsWidgetState();
}

class _HomePagePatientsWidgetState extends State<HomePagePatientsWidget> {
  bool _isLoading;
  var fetchFuture;

  initState() {
    fetchFuture = refreshListOfPatients(context);
  }

  Future<void> refreshListOfPatients(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Patients>(context, listen: false)
        .fetchPatientsListFromServer('bGxFisQYmYl8ypnsBDtN');
    setState(() {
      _isLoading = false;
    });
    // await Provider.of<Appointments>(context, listen: false)
    //     .fetchAppointmentsFromFirebase();

    print("refreshListOfPatients called");
    // setState(() {
    //   _isLoading = false;
    //   // appointments = Provider.of<Appointments>(context, listen: false)
    //   //     .fetchedAppointmentList;
    // });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
            ),
            Provider.of<Patients>(context,listen:true).isFetching==true?Center(child: CircularProgressIndicator(backgroundColor: Colors.black,)):
           Flexible(
                flex: 8,
                child: RefreshIndicator(
              onRefresh: () => refreshListOfPatients(context),
              child:  Container(
             //     height:MediaQuery.of(context).size.height,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: Provider.of<Patients>(context, listen: true)
                          .fetchedPatientsList
                          .length,
                      itemBuilder: (context, position) {
                        return PatientSummaryWidget(
                            patient:
                                Provider.of<Patients>(context, listen: true)
                                    .fetchedPatientsList[position]);
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


