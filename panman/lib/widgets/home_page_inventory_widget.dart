import 'package:flutter/material.dart';
import 'package:panman/models/hospital.dart';
import 'package:provider/provider.dart';

import '../models/medicalSupply.dart';

import '../providers/hospital.dart';

class HomePageInvetoryWidget extends StatefulWidget {
  @override
  _HomePageInvetoryWidgetState createState() => _HomePageInvetoryWidgetState();
}

class _HomePageInvetoryWidgetState extends State<HomePageInvetoryWidget> {
  final formKey = GlobalKey<FormState>();
  int value_to_submit = 0;
  bool waitingForResult = false;
  // final tripleLayerMask = TextEditingController();
  // final n95MaskController = TextEditingController();
  // final faceShieldController = TextEditingController();
  // final goggleController = TextEditingController();
  // final headCoverController = TextEditingController();
  // final apronCoverController = TextEditingController();
  // final shoeCoverController = TextEditingController();

  @override
  medicalSupplyCard(medicalSupply item) {
    return Card(
      //  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Container(
          //      height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Text(
                        item.id,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              item.qty.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                            Text("Available",
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (text) {
                            print(text);
                            setState(() {
                              value_to_submit = int.parse(text);
                            });
                          },
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.black12),
                            labelText: "Remaining qty.",
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: waitingForResult
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              "UPDATE QUANTITY",
                              style: Theme.of(context).textTheme.caption,
                            ),
                      onPressed: () async {
                        waitingForResult = true;

                        await Provider.of<Hospitals>(context, listen: false)
                            .updateQuantity(item, value_to_submit);
                        waitingForResult = false;
                      },
                    ),
                  ),
                ),
              ),
              // RaisedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future fetchFuture;
  bool _isLoading = false;

  initState() {
    fetchFuture = refreshHospitalDetails(context);
  }

  Future<void> refreshHospitalDetails(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Hospitals>(context, listen: false)
        .getHospitalDetailsFromServer('bGxFisQYmYl8ypnsBDtN');
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
    return Container(
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: RefreshIndicator(
              onRefresh: () => refreshHospitalDetails(context),
              child: Container(
                // color: Colors.red,
                child: _isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formKey,
                          child: ListView.builder(
                            itemCount:
                                Provider.of<Hospitals>(context, listen: true)
                                    .fetchedHospital
                                    .medicalSupplies
                                    .length,
                            itemBuilder: (context, position) {
                              return medicalSupplyCard(
                                  Provider.of<Hospitals>(context, listen: true)
                                      .fetchedHospital
                                      .medicalSupplies[position]);
                            },
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
