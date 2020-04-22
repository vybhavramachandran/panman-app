import 'package:flutter/material.dart';
import 'package:panman/providers/healthcareworkers.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';

import './patient_summary_widget.dart';

class HomePagePatientsWidget extends StatefulWidget {
  bool triggerRefreshOfPatientList;
  Function patientListRefreshed;

  HomePagePatientsWidget(
      {this.triggerRefreshOfPatientList, this.patientListRefreshed});
  @override
  _HomePagePatientsWidgetState createState() => _HomePagePatientsWidgetState();
}

class _HomePagePatientsWidgetState extends State<HomePagePatientsWidget> {
  bool _isLoading;
  var fetchFuture;
  bool shouldSkip = false;

  TextEditingController searchTextController = new TextEditingController();

  initState() {
        super.initState();

    fetchFuture = refreshListOfPatients(context);
    shouldSkip = true;
  }

  Future refreshListOfPatients(BuildContext context) async {
    var hospitalID = Provider.of<HealthCareWorkers>(context, listen: false)
        .hcwloggedin
        .hospitalID;

    print("refreshListOfPatients called");
    return await Provider.of<Patients>(context, listen: false)
        .fetchPatientsListFromServer(hospitalID);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<Patients>(context, listen: true).shouldRefreshList ==
        true) {
      refreshListOfPatients(context);
    }
    // refreshListOfPatients(context);
    // if (shouldSkip == true) {
    //   shouldSkip = false;
    // } else {
    //   print('didchangedepenceies called');
    //   // TODO: implement didChangeDependencies
    //   super.didChangeDependencies();
    //   fetchFuture = refreshListOfPatients(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
           // height:100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                
                controller: searchTextController,
                onChanged: (String value) {
                  return Provider.of<Patients>(context, listen: false)
                      .onSearchTextChanged(value);
                },
                // controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search,color: Colors.black54,),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                   ),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: FutureBuilder(
              future: fetchFuture,
              builder: (ctx, snapshot) => snapshot.connectionState !=
                          ConnectionState.done &&
                      !snapshot.hasData
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
                            itemCount: searchTextController.text.isEmpty
                                ? Provider.of<Patients>(context, listen: true)
                                    .fetchedPatientsList
                                    .length
                                : Provider.of<Patients>(context, listen: true)
                                    .filteredPatientsList
                                    .length,
                            itemBuilder: (context, position) {
                              return PatientSummaryWidget(
                                  patient: searchTextController.text.isEmpty
                                      ? Provider.of<Patients>(context,
                                              listen: true)
                                          .fetchedPatientsList[position]
                                      : Provider.of<Patients>(context,
                                              listen: true)
                                          .filteredPatientsList[position]);
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
