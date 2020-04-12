import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/test.dart';

import '../providers/patients.dart';
import '../widgets/patient_detailed_header.dart';
import 'package:intl/intl.dart';

class AddTestScreen extends StatefulWidget {
  static const routeName = '/add_test_screen';

  @override
  _AddTestScreenState createState() => _AddTestScreenState();
}

class _AddTestScreenState extends State<AddTestScreen> {
  Test newTest = Test();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              "PATIENT/ADD TEST",
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
        body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("TEST DETAILS",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black)),
                    SizedBox(height: 20),
                    Text("Enter the test details",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                DateTimeField(
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                    labelText: "Select Submission Date",
                    // hintText: "Event",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                  ),
                  initialValue: DateTime.now(),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2021));
                    setState(() {
                      newTest.submissionDate = date;
                    });
                    return date;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  //  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                    labelText: "Testing Center",
                    // hintText: "Event",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                  ),
                  onSaved: (String value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                 DateTimeField(
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                    labelText: "Select result date",
                    // hintText: "Event",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300])),
                  ),
                //  initialValue: DateTime.now(),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2021));
                    setState(() {
                      newTest.resultDate = date;
                    });
                    return date;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: DropdownButton<String>(
                    value: newTest.result,
                    hint: Text("Test Result"),
                    items: ["Positive", "Negative", "Inconclusive"]
                        .map((String selectedResult) {
                      return new DropdownMenuItem<String>(
                        value: selectedResult,
                        child: new Text(selectedResult),
                      );
                    }).toList(),
                    onChanged: (String a) {
                      setState(() {
                        newTest.result = a;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: DropdownButton<String>(
                    value: newTest.reportStatus,
                    hint: Text("Test Report Status"),
                    items: ["Pending", "Received"].map((String selectedStatus) {
                      return new DropdownMenuItem<String>(
                        value: selectedStatus,
                        child: new Text(selectedStatus),
                      );
                    }).toList(),
                    onChanged: (String a) {
                      setState(() {
                        newTest.reportStatus = a;
                      });
                    },
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    height: 64.0,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).accentColor,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
