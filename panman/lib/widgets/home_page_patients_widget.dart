import 'package:flutter/material.dart';
import 'package:panman/providers/healthcareworkers.dart';
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
    super.initState();
  }

  Future refreshListOfPatients(BuildContext context) async {
    var hospitalID = Provider.of<HealthCareWorkers>(context,listen:true).hcwloggedin.hospitalID;

    print("refreshListOfPatients called");
    return await Provider.of<Patients>(context, listen: false)
        .fetchPatientsListFromServer(hospitalID);
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
            Flexible(
              flex: 8,
              child: FutureBuilder(
                future: fetchFuture,
                builder: (ctx, snapshot) => snapshot.connectionState !=
                        ConnectionState.done && !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => refreshListOfPatients(context),
                        child: Container(
                          //     height:MediaQuery.of(context).size.height,
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount:
                                  Provider.of<Patients>(context, listen: true)
                                      .fetchedPatientsList
                                      .length,
                              itemBuilder: (context, position) {
                                return PatientSummaryWidget(
                                    patient: Provider.of<Patients>(context,
                                            listen: true)
                                        .fetchedPatientsList[position]);
                              },
                            ),
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
