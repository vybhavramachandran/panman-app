import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panman/models/address.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:panman/screens/patient_screening.dart';
import 'package:provider/provider.dart';

class PatientRegistrationScreen extends StatefulWidget {
  @override
  _PatientRegistrationScreenState createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  _pickImage(Patient patient) async {
    patient.pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted) setState(() {});
  }

  _submitPatient() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PatientScreeningScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Patient newPatient = Provider.of<Patients>(context).newPatient;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'PATIENT REGISTRATION',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          onSaved: (v) => newPatient.Firstname = v,
                          validator: (v) =>
                              v.isEmpty ? 'Please enter some text' : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusColor: Color(0xFF6200EE),
                            labelText: 'Name',
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 32.0),
                        TextFormField(
                          onSaved: (v) => newPatient.age = int.parse(v),
                          validator: (v) =>
                              v.isEmpty ? 'Please enter some text' : null,
                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusColor: Color(0xFF6200EE),
                            labelText: 'Age',
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 32.0),
                        Row(
                          children: <Widget>[
                            Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                onSaved: (v) => newPatient.phoneNumber = v,
                                validator: (v) =>
                                    v.isEmpty ? 'Please enter some text' : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.5),
                                  ),
                                  focusColor: Color(0xFF6200EE),
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.0),
                        TextFormField(
                          onSaved: (v) =>
                              newPatient.fullAddress = FullAddress(address: v),
                          validator: (v) =>
                              v.isEmpty ? 'Please enter some text' : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.5),
                            ),
                            focusColor: Color(0xFF6200EE),
                            labelText: 'Address',
                            labelStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 32.0),
                        Text(
                          'PHOTO',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        GestureDetector(
                          onTap: () => _pickImage(newPatient),
                          child: Container(
                            height: 116,
                            width: 116,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFDADADA),
                              ),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: newPatient.pic == null
                                ? Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFFDADADA),
                                    ),
                                  )
                                : Image.file(newPatient.pic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => _submitPatient(),
            child: Container(
              height: 64.0,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  'MOVE PATIENT TO SCREENING',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
