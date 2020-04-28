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
  List<String> filters;
  bool patientsInHospital;
  bool filterScreening;
  bool filterSuspectedIsolation;
  bool filterConfirmedIsolation;
  bool filterICU;
  bool filterDischarged;
  bool filterDeceased;
  bool patientsDischarged;
  bool filterTransferred;
  bool shouldSkip = false;

  TextEditingController searchTextController = new TextEditingController();

  initState() {
    super.initState();
    shouldSkip = true;
    filters = [];
    patientsInHospital = true;
    patientsDischarged = false;
    filterScreening = true;
    filterSuspectedIsolation = true;
    filterConfirmedIsolation = true;
    filterICU = true;
    filterDischarged = false;
    filterTransferred = false;
    filterDeceased = false;
    fetchFuture = refreshListOfPatients(context);
  }

  List returnFilterList() {
    List filterList = [];
    if (filterDischarged == true) {
      filterList.add(0);
    }
    if (filterScreening == true) {
      filterList.add(2);
    }
    if (filterSuspectedIsolation == true) {
      filterList.add(3);
    }
    if (filterConfirmedIsolation == true) {
      filterList.add(4);
    }
    if (filterICU == true) {
      filterList.add(5);
    }
    if (filterTransferred == true) {
      filterList.add(6);
    }
    if (filterDeceased == true) {
      filterList.add(7);
    }
    print("returnFilterList called $filterList");

    return filterList;
  }

  Future refreshListOfPatients(BuildContext context) async {
    var hospitalID = Provider.of<HealthCareWorkers>(context, listen: false)
        .hcwloggedin
        .hospitalID;

    print("refreshListOfPatients called");
    return await Provider.of<Patients>(context, listen: false)
        .fetchPatientsListFromServer(hospitalID, returnFilterList());
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

  didChan() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text("Filter : ",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.black)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterScreening == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("Screening"),
                        selected: filterScreening,
                        onSelected: (bool value) async {
                          setState(() {
                            filterScreening = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterSuspectedIsolation == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("Suspected Isolation"),
                        selected: filterSuspectedIsolation,
                        onSelected: (bool value) {
                          setState(() {
                            filterSuspectedIsolation = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterConfirmedIsolation == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("Confirmed Isolation"),
                        selected: filterConfirmedIsolation,
                        onSelected: (bool value) {
                          setState(() {
                            filterConfirmedIsolation = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterICU == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("ICU"),
                        selected: filterICU,
                        onSelected: (bool value) {
                          setState(() {
                            filterICU = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterDischarged == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("Discharged"),
                        selected: filterDischarged,
                        onSelected: (bool value) {
                          setState(() {
                            filterDischarged = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        showCheckmark: false,
                        labelStyle: filterDeceased == true
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        label: Text("Deceased"),
                        selected: filterDeceased,
                        onSelected: (bool value) {
                          setState(() {
                            filterDeceased = value;
                          });
                          refreshListOfPatients(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
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
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
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
