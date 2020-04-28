import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panman/models/address.dart';
import 'package:panman/models/patient.dart';
import 'package:panman/providers/patients.dart';
import 'package:panman/screens/patient_contact_tracing.dart';
import 'package:panman/screens/patient_screening.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'package:string_validator/string_validator.dart';

import '../providers/hospital.dart';

import '../models/delhiSpecificDetails.dart';

import '../providers/covid19.dart';

import 'dart:convert';

class PatientRegistrationScreen extends StatefulWidget {
  static const routeName = '/patient_registration_screen';

  @override
  _PatientRegistrationScreenState createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  static var delhiZipCodes = [
    {"Area": "A.G.c.r.", "Pincode": 110002, "Disctrict": "Central Delhi"},
    {"Area": "A.K.market", "Pincode": 110055, "Disctrict": "Central Delhi"},
    {
      "Area": "Ajmeri Gate extn.",
      "Pincode": 110002,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Anand Parbat", "Pincode": 110005, "Disctrict": "Central Delhi"},
    {
      "Area": "Anand Parbat indl. area",
      "Pincode": 110005,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Bank Street", "Pincode": 110005, "Disctrict": "Central Delhi"},
    {"Area": "Baroda House", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Bengali Market", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {
      "Area": "Bhagat Singh market",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Connaught Place",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Constitution House",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Dada Ghosh bhawan",
      "Pincode": 110008,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Darya Ganj", "Pincode": 110002, "Disctrict": "Central Delhi"},
    {
      "Area": "Delhi High court",
      "Pincode": 110003,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Desh Bandhu gupta road",
      "Pincode": 110005,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Election Commission",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Gandhi Smarak nidhi",
      "Pincode": 110002,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Guru Gobind singh marg",
      "Pincode": 110005,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Gym Khana club", "Pincode": 110011, "Disctrict": "Central Delhi"},
    {"Area": "Hauz Qazi", "Pincode": 110006, "Disctrict": "Central Delhi"},
    {"Area": "I.A.r.i.", "Pincode": 110012, "Disctrict": "Central Delhi"},
    {"Area": "I.P.estate", "Pincode": 110002, "Disctrict": "Central Delhi"},
    {"Area": "Inderpuri", "Pincode": 110012, "Disctrict": "Central Delhi"},
    {"Area": "Indraprastha", "Pincode": 110002, "Disctrict": "Central Delhi"},
    {"Area": "Jama Masjid", "Pincode": 110006, "Disctrict": "Central Delhi"},
    {"Area": "Janpath", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Karol Bagh", "Pincode": 110005, "Disctrict": "Central Delhi"},
    {"Area": "Krishi Bhawan", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {
      "Area": "Lady Harding medical college",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Master Prithvi nath marg",
      "Pincode": 110005,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Minto Road", "Pincode": 110002, "Disctrict": "Central Delhi"},
    {"Area": "Multani Dhanda", "Pincode": 110055, "Disctrict": "Central Delhi"},
    {
      "Area": "National Physical laboratory",
      "Pincode": 110012,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Nirman Bhawan", "Pincode": 110011, "Disctrict": "Central Delhi"},
    {"Area": "North Avenue", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Pahar Ganj", "Pincode": 110055, "Disctrict": "Central Delhi"},
    {"Area": "Pandara Road", "Pincode": 110003, "Disctrict": "Central Delhi"},
    {
      "Area": "Parliament House",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Patel Nagar", "Pincode": 110008, "Disctrict": "Central Delhi"},
    {
      "Area": "Patel Nagar east",
      "Pincode": 110008,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Patel Nagar south",
      "Pincode": 110008,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Patel Nagar west",
      "Pincode": 110008,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Patiala House", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Pragati Maidan", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Rail Bhawan", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "Rajender Nagar", "Pincode": 110060, "Disctrict": "Central Delhi"},
    {
      "Area": "Rajghat Power house",
      "Pincode": 110002,
      "Disctrict": "Central Delhi"
    },
    {
      "Area": "Rashtrapati Bhawan",
      "Pincode": 110004,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Sansad Marg", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {
      "Area": "Sansadiya Soudh",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Sat Nagar", "Pincode": 110005, "Disctrict": "Central Delhi"},
    {
      "Area": "Secretariat North",
      "Pincode": 110001,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Shastri Bhawan", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {"Area": "South Avenue", "Pincode": 110011, "Disctrict": "Central Delhi"},
    {"Area": "Supreme Court", "Pincode": 110001, "Disctrict": "Central Delhi"},
    {
      "Area": "Swami Ram tirth nagar",
      "Pincode": 110055,
      "Disctrict": "Central Delhi"
    },
    {"Area": "Udyog Bhawan", "Pincode": 110011, "Disctrict": "Central Delhi"},
    {
      "Area": "Union Public service commission",
      "Pincode": 110069,
      "Disctrict": "Central Delhi"
    },
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {"Area": "Anand Vihar", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "Azad Nagar", "Pincode": 110051, "Disctrict": "East Delhi"},
    {"Area": "Badarpur Khadar", "Pincode": 110090, "Disctrict": "East Delhi"},
    {"Area": "Balbir Nagar", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Bhola Nath Nagar", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Brahampuri", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Chilla", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "Dilshad Garden", "Pincode": 110095, "Disctrict": "East Delhi"},
    {
      "Area": "Distt. Court (KKD)",
      "Pincode": 110032,
      "Disctrict": "East Delhi"
    },
    {"Area": "G.T.B. Hospital", "Pincode": 110095, "Disctrict": "East Delhi"},
    {
      "Area": "Gandhi Nagar Bazar",
      "Pincode": 110031,
      "Disctrict": "East Delhi"
    },
    {"Area": "Gandhi Nagar", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Garhi Mandu", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Geeta Colony", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Ghazipur", "Pincode": 110096, "Disctrict": "East Delhi"},
    {"Area": "Ghonda", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Gokal Puri", "Pincode": 110094, "Disctrict": "East Delhi"},
    {
      "Area": "Goverdhan Bihari Colony",
      "Pincode": 110032,
      "Disctrict": "East Delhi"
    },
    {"Area": "Govind Pura", "Pincode": 110051, "Disctrict": "East Delhi"},
    {"Area": "Harsh Vihar", "Pincode": 110093, "Disctrict": "East Delhi"},
    {"Area": "Himmatpuri", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "IP Extension", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "Jafrabad", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Jagjit Nagar", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Jhilmil", "Pincode": 110095, "Disctrict": "East Delhi"},
    {
      "Area": "Jhilmil Tahirpur B.O",
      "Pincode": 110095,
      "Disctrict": "East Delhi"
    },
    {"Area": "Johripur", "Pincode": 110094, "Disctrict": "East Delhi"},
    {"Area": "Kailash Nagar", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Kalyanpuri", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "Kalyanvas", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "Karawal Nagar", "Pincode": 110090, "Disctrict": "East Delhi"},
    {"Area": "Khazuri Khas", "Pincode": 110094, "Disctrict": "East Delhi"},
    {"Area": "Krishna Nagar", "Pincode": 110051, "Disctrict": "East Delhi"},
    {"Area": "Laxmi Nagar", "Pincode": 110092, "Disctrict": "East Delhi"},
    {
      "Area": "Loni Road Housing Complex",
      "Pincode": 110093,
      "Disctrict": "East Delhi"
    },
    {"Area": "Loni Road", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Man Sarovar Park", "Pincode": 110032, "Disctrict": "East Delhi"},
    {
      "Area": "Mandawali Fazalpur",
      "Pincode": 110092,
      "Disctrict": "East Delhi"
    },
    {"Area": "Maujpur", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Mayur Vihar Ph-I", "Pincode": 110091, "Disctrict": "East Delhi"},
    {
      "Area": "Mayur Vihar Ph-III",
      "Pincode": 110096,
      "Disctrict": "East Delhi"
    },
    {"Area": "Nand Nagri \"A", "Pincode": 110093, "Disctrict": "East Delhi"},
    {"Area": "Nand Nagri \"C", "Pincode": 110093, "Disctrict": "East Delhi"},
    {"Area": "New Seemapuri", "Pincode": 110095, "Disctrict": "East Delhi"},
    {"Area": "New Usmanpur", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Nirman Vihar", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "Old Seemapuri", "Pincode": 110095, "Disctrict": "East Delhi"},
    {"Area": "Patparganj", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "Raghubar Pura", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Rajgarh Colony", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Ram Nagar", "Pincode": 110051, "Disctrict": "East Delhi"},
    {"Area": "Rohtash Nagar", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Seelampur", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Shahdara Mandi", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Shahdara", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Shakarpur", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "Shastri Nagar", "Pincode": 110031, "Disctrict": "East Delhi"},
    {"Area": "Shivaji Park", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Sonia Vihar", "Pincode": 110090, "Disctrict": "East Delhi"},
    {"Area": "Surajmal Vihar", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "Telewara", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Trilok Puri", "Pincode": 110091, "Disctrict": "East Delhi"},
    {"Area": "V.K. Nagar", "Pincode": 110095, "Disctrict": "East Delhi"},
    {"Area": "Vasundhra Enclave", "Pincode": 110096, "Disctrict": "East Delhi"},
    {"Area": "Vishwas Nagar", "Pincode": 110032, "Disctrict": "East Delhi"},
    {"Area": "Vivek Vihar", "Pincode": 110095, "Disctrict": "East Delhi"},
    {"Area": "Yamuna Vihar", "Pincode": 110053, "Disctrict": "East Delhi"},
    {"Area": "Yozna Vihar", "Pincode": 110092, "Disctrict": "East Delhi"},
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {"Area": "F F C Okhla", "Pincode": 110020, "Disctrict": "New Delhi"},
    {"Area": "Nauroji Nagar", "Pincode": 110029, "Disctrict": "New Delhi"},
    {"Area": "New Delhi G.P.O.", "Pincode": 110001, "Disctrict": "New Delhi"},
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {"Area": "Aruna Nagar", "Pincode": 110054, "Disctrict": "North Delhi"},
    {"Area": "Avantika", "Pincode": 110085, "Disctrict": "North Delhi"},
    {"Area": "Baratooti", "Pincode": 110006, "Disctrict": "North Delhi"},
    {"Area": "Burari", "Pincode": 110084, "Disctrict": "North Delhi"},
    {"Area": "C.C.I.", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Chandni Chowk", "Pincode": 110006, "Disctrict": "North Delhi"},
    {"Area": "Chawri Bazar", "Pincode": 110006, "Disctrict": "North Delhi"},
    {"Area": "Civil Lines", "Pincode": 110054, "Disctrict": "North Delhi"},
    {"Area": "Dareeba", "Pincode": 110006, "Disctrict": "North Delhi"},
    {"Area": "Delhi G.P.O.", "Pincode": 110006, "Disctrict": "North Delhi"},
    {
      "Area": "Delhi Sadar Bazar",
      "Pincode": 110006,
      "Disctrict": "North Delhi"
    },
    {"Area": "Delhi University", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "District Courts", "Pincode": 110054, "Disctrict": "North Delhi"},
    {"Area": "Gulabi Bagh", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Jagatpur", "Pincode": 110084, "Disctrict": "North Delhi"},
    {"Area": "Jawahar Nagar", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Jharoda Majraa", "Pincode": 110084, "Disctrict": "North Delhi"},
    {"Area": "Kamla Nagar", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Majnu ka a", "Pincode": 110054, "Disctrict": "North Delhi"},
    {"Area": "Malka Ganj", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Padam Nagar", "Pincode": 110007, "Disctrict": "North Delhi"},
    {
      "Area": "Patrachar Vidyalay",
      "Pincode": 110054,
      "Disctrict": "North Delhi"
    },
    {"Area": "R.C.A.O.", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Rana Pratap Bagh", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Roop Nagar", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Roshan Ara Road", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "S.T. Road", "Pincode": 110006, "Disctrict": "North Delhi"},
    {"Area": "Shakti Nagar", "Pincode": 110007, "Disctrict": "North Delhi"},
    {"Area": "Timarpur", "Pincode": 110054, "Disctrict": "North Delhi"},
    {
      "Area": "Wazirabad Village",
      "Pincode": 110084,
      "Disctrict": "North Delhi"
    },
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {"Area": "Babarpur", "Pincode": 110032, "Disctrict": "North East Delhi"},
    {"Area": "Bhajan Pura", "Pincode": 110053, "Disctrict": "North East Delhi"},
    {"Area": "Dayalpur", "Pincode": 110094, "Disctrict": "North East Delhi"},
    {
      "Area": "Mandoli Saboli",
      "Pincode": 110093,
      "Disctrict": "North East Delhi"
    },
    {
      "Area": "Shaheed Bhagat Singh Colony",
      "Pincode": 110090,
      "Disctrict": "North East Delhi"
    },
    {
      "Area": "Shriram Colony Rajeev Nagar",
      "Pincode": 110090,
      "Disctrict": "North East Delhi"
    },
    {
      "Area": "Sunder Nagari",
      "Pincode": 110093,
      "Disctrict": "North East Delhi"
    },
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {
      "Area": "Adrash Nagar",
      "Pincode": 110033,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Alipur", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {
      "Area": "Anandvas Shakurpur",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Ashok Vihar", "Pincode": 110052, "Disctrict": "North West Delhi"},
    {"Area": "Auchandi", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Badli", "Pincode": 110042, "Disctrict": "North West Delhi"},
    {
      "Area": "Bakhtawar Pur",
      "Pincode": 110036,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Bakoli", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {"Area": "Bankner", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {"Area": "Barwala", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Bawana", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Begumpur", "Pincode": 110086, "Disctrict": "North West Delhi"},
    {"Area": "Bhalaswa", "Pincode": 110033, "Disctrict": "North West Delhi"},
    {"Area": "Bhorgarh", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {"Area": "Budh Vihar", "Pincode": 110086, "Disctrict": "North West Delhi"},
    {"Area": "Chand Pur", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {
      "Area": "Daryapur Kalan",
      "Pincode": 110039,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Delhi Engg. College",
      "Pincode": 110042,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Dr.Mukerjee Nagar",
      "Pincode": 110009,
      "Disctrict": "North West Delhi"
    },
    {"Area": "G.T.B.Nagar", "Pincode": 110009, "Disctrict": "North West Delhi"},
    {"Area": "Ganeshpura", "Pincode": 110035, "Disctrict": "North West Delhi"},
    {"Area": "Gheora", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Ghoga", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {
      "Area": "Gujranwala Colony",
      "Pincode": 110009,
      "Disctrict": "North West Delhi"
    },
    {"Area": "H.S.Sangh", "Pincode": 110009, "Disctrict": "North West Delhi"},
    {"Area": "Haiderpur", "Pincode": 110088, "Disctrict": "North West Delhi"},
    {"Area": "Hareveli", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Hiranki", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {
      "Area": "Holambi Kalan",
      "Pincode": 110082,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Jahangir Puri A Block",
      "Pincode": 110033,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Jahangir Puri D Block",
      "Pincode": 110033,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Jahangir Puri H Block",
      "Pincode": 110033,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Jat Khore", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Jaunti", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Kadipur", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {"Area": "Kanjhawla", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {
      "Area": "Kanya Gurukul",
      "Pincode": 110040,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Karala", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Katewara", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {
      "Area": "Keshav Puram",
      "Pincode": 110035,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Khampur", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {"Area": "Khera Kalan", "Pincode": 110082, "Disctrict": "North West Delhi"},
    {"Area": "Khera Khurd", "Pincode": 110082, "Disctrict": "North West Delhi"},
    {"Area": "Lad Pur", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Lampur", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {"Area": "Majra Dabas", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {
      "Area": "Mangolpuri A Block",
      "Pincode": 110083,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Mangolpuri I Block",
      "Pincode": 110083,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Mangolpuri N Block",
      "Pincode": 110083,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Mangolpuri S Block",
      "Pincode": 110083,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Maurya Enclave",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Model Town II",
      "Pincode": 110009,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Model Town III",
      "Pincode": 110009,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Mubarak Pur Dabas",
      "Pincode": 110081,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Mukhmelpur", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {"Area": "Mungeshpur", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "N.S.Mandi", "Pincode": 110033, "Disctrict": "North West Delhi"},
    {"Area": "Naharpur", "Pincode": 110085, "Disctrict": "North West Delhi"},
    {
      "Area": "Nangal Poona",
      "Pincode": 110036,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Nangal Thakran",
      "Pincode": 110039,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Narela", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {"Area": "Naya Bans", "Pincode": 110082, "Disctrict": "North West Delhi"},
    {
      "Area": "New Multan Nagar",
      "Pincode": 110056,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Nimri", "Pincode": 110052, "Disctrict": "North West Delhi"},
    {
      "Area": "Nirankari Colony",
      "Pincode": 110009,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Nizampur", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Onkar Nagar", "Pincode": 110035, "Disctrict": "North West Delhi"},
    {"Area": "Palla", "Pincode": 110036, "Disctrict": "North West Delhi"},
    {"Area": "Pehlad Pur", "Pincode": 110042, "Disctrict": "North West Delhi"},
    {"Area": "Pooth Kalan", "Pincode": 110086, "Disctrict": "North West Delhi"},
    {
      "Area": "Pooth Kalan Resettlement",
      "Pincode": 110086,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Pooth Khurd", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Power House", "Pincode": 110035, "Disctrict": "North West Delhi"},
    {
      "Area": "Prashant Vihar",
      "Pincode": 110085,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Prem Nagar", "Pincode": 110086, "Disctrict": "North West Delhi"},
    {"Area": "Punjab Khor", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Qutabagarh", "Pincode": 110039, "Disctrict": "North West Delhi"},
    {"Area": "Rampura", "Pincode": 110035, "Disctrict": "North West Delhi"},
    {"Area": "Rani Bagh", "Pincode": 110034, "Disctrict": "North West Delhi"},
    {"Area": "Rani Khera", "Pincode": 110081, "Disctrict": "North West Delhi"},
    {"Area": "Rithala", "Pincode": 110085, "Disctrict": "North West Delhi"},
    {
      "Area": "Rohini Courts",
      "Pincode": 110085,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Rohini sec-11",
      "Pincode": 110085,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Rohini Sector 15",
      "Pincode": 110089,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Rohini Sector 5",
      "Pincode": 110085,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Rohini Sector-7",
      "Pincode": 110085,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Sabhapur", "Pincode": 110094, "Disctrict": "North West Delhi"},
    {"Area": "Samai Pur", "Pincode": 110042, "Disctrict": "North West Delhi"},
    {"Area": "Sanoth", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {
      "Area": "Sarai Rohilla",
      "Pincode": 110035,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Saraswati Vihar",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Satyawati Nagar",
      "Pincode": 110052,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Shahbad Daulatpur",
      "Pincode": 110042,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Shakur Basti Depot",
      "Pincode": 110056,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Shakur Pur I Block",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Shakurbasti Rs",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Shalamar", "Pincode": 110088, "Disctrict": "North West Delhi"},
    {
      "Area": "Shalimar Bagh",
      "Pincode": 110088,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Shastri Nagar",
      "Pincode": 110052,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Singhu", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {"Area": "Siraspur", "Pincode": 110042, "Disctrict": "North West Delhi"},
    {
      "Area": "Sri Nagar Colony",
      "Pincode": 110034,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Sultanpuri B Block",
      "Pincode": 110086,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Sultanpuri C Block",
      "Pincode": 110086,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Sultanpuri F Block",
      "Pincode": 110086,
      "Disctrict": "North West Delhi"
    },
    {
      "Area": "Tajpur Kalan",
      "Pincode": 110036,
      "Disctrict": "North West Delhi"
    },
    {"Area": "Tikri Khurd", "Pincode": 110040, "Disctrict": "North West Delhi"},
    {
      "Area": "Wazir Pur III",
      "Pincode": 110052,
      "Disctrict": "North West Delhi"
    },
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {
      "Area": "Abul Fazal Enclave-I",
      "Pincode": 110025,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Air Force Station Tugalkabad",
      "Pincode": 110062,
      "Disctrict": "South Delhi"
    },
    {"Area": "Alaknanda", "Pincode": 110019, "Disctrict": "South Delhi"},
    {"Area": "Ali", "Pincode": 110076, "Disctrict": "South Delhi"},
    {"Area": "Aliganj", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Amar Colony", "Pincode": 110024, "Disctrict": "South Delhi"},
    {"Area": "Andrewsganj", "Pincode": 110049, "Disctrict": "South Delhi"},
    {"Area": "Badarpur", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "BSF Camp Tigri", "Pincode": 110062, "Disctrict": "South Delhi"},
    {"Area": "BTPS", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "C G O Complex", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Chittranjan Park", "Pincode": 110019, "Disctrict": "South Delhi"},
    {"Area": "CRRI", "Pincode": 110020, "Disctrict": "South Delhi"},
    {
      "Area": "Dakshinpuri Phase-I",
      "Pincode": 110062,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Dakshinpuri Phase-II",
      "Pincode": 110062,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Dakshinpuri Phase-III",
      "Pincode": 110062,
      "Disctrict": "South Delhi"
    },
    {"Area": "Dargah Sharif", "Pincode": 110013, "Disctrict": "South Delhi"},
    {"Area": "Defence Colony", "Pincode": 110024, "Disctrict": "South Delhi"},
    {"Area": "Deoli", "Pincode": 110062, "Disctrict": "South Delhi"},
    {
      "Area": "Distt. Court Complex, Saket",
      "Pincode": 110017,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Dr. Ambedkar Nagar",
      "Pincode": 110062,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "East Of Kailash Phase-I",
      "Pincode": 110065,
      "Disctrict": "South Delhi"
    },
    {"Area": "East Of Kailash", "Pincode": 110065, "Disctrict": "South Delhi"},
    {"Area": "Gautam Nagar", "Pincode": 110049, "Disctrict": "South Delhi"},
    {"Area": "Golf Links", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Greater Kailash", "Pincode": 110048, "Disctrict": "South Delhi"},
    {"Area": "Gulmohar Park", "Pincode": 110049, "Disctrict": "South Delhi"},
    {"Area": "Hamdard Nagar", "Pincode": 110062, "Disctrict": "South Delhi"},
    {
      "Area": "Hari Nagar Ashram",
      "Pincode": 110014,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Hazrat Nizamuddin",
      "Pincode": 110013,
      "Disctrict": "South Delhi"
    },
    {"Area": "Jaitpur", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "Jaitpur", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "Jamia Nagar", "Pincode": 110025, "Disctrict": "South Delhi"},
    {"Area": "Jeevan Nagar", "Pincode": 110014, "Disctrict": "South Delhi"},
    {"Area": "Jungpura", "Pincode": 110014, "Disctrict": "South Delhi"},
    {"Area": "Kailash Colony", "Pincode": 110048, "Disctrict": "South Delhi"},
    {"Area": "Kalkaji", "Pincode": 110019, "Disctrict": "South Delhi"},
    {"Area": "Kasturba Nagar", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Khanpur", "Pincode": 110062, "Disctrict": "South Delhi"},
    {"Area": "Krishna Market", "Pincode": 110024, "Disctrict": "South Delhi"},
    {"Area": "Lajpat Nagar", "Pincode": 110024, "Disctrict": "South Delhi"},
    {"Area": "Lal Kuan", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "Lodi Road", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Madanpur Khadar", "Pincode": 110076, "Disctrict": "South Delhi"},
    {"Area": "Malviya Nagar", "Pincode": 110017, "Disctrict": "South Delhi"},
    {"Area": "Masjid Moth", "Pincode": 110048, "Disctrict": "South Delhi"},
    {"Area": "MMTC/STC Colony", "Pincode": 110017, "Disctrict": "South Delhi"},
    {"Area": "Molarband", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "Nehru Nagar", "Pincode": 110065, "Disctrict": "South Delhi"},
    {"Area": "Nehru Place", "Pincode": 110019, "Disctrict": "South Delhi"},
    {
      "Area": "New Delhi South Ext-II",
      "Pincode": 110049,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "New Friends Colony",
      "Pincode": 110025,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Okhla Industrial Area Phase-i",
      "Pincode": 110020,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Okhla Industrial Estate",
      "Pincode": 110020,
      "Disctrict": "South Delhi"
    },
    {
      "Area": "Panchsheel Enclave",
      "Pincode": 110017,
      "Disctrict": "South Delhi"
    },
    {"Area": "Pragati Vihar", "Pincode": 110003, "Disctrict": "South Delhi"},
    {"Area": "Pratap Market", "Pincode": 110014, "Disctrict": "South Delhi"},
    {"Area": "Pul Pahladpur", "Pincode": 110044, "Disctrict": "South Delhi"},
    {"Area": "Pushp Vihar", "Pincode": 110017, "Disctrict": "South Delhi"},
    {"Area": "Pushpa Bhawan", "Pincode": 110062, "Disctrict": "South Delhi"},
    {"Area": "Sadiq Nagar", "Pincode": 110049, "Disctrict": "South Delhi"},
    {
      "Area": "Safdarjung Air Port",
      "Pincode": 110003,
      "Disctrict": "South Delhi"
    },
    {"Area": "Sahpurjat", "Pincode": 110049, "Disctrict": "South Delhi"},
    {"Area": "Saket", "Pincode": 110017, "Disctrict": "South Delhi"},
    {"Area": "Sangam Vihar", "Pincode": 110080, "Disctrict": "South Delhi"},
    {"Area": "Sant Nagar", "Pincode": 110065, "Disctrict": "South Delhi"},
    {"Area": "Sarita Vihar", "Pincode": 110076, "Disctrict": "South Delhi"},
    {"Area": "Sarvodya Enclave", "Pincode": 110017, "Disctrict": "South Delhi"},
    {
      "Area": "South Malviya Nagar",
      "Pincode": 110017,
      "Disctrict": "South Delhi"
    },
    {"Area": "Sriniwaspuri", "Pincode": 110065, "Disctrict": "South Delhi"},
    {"Area": "Sukhdev Vihar", "Pincode": 110025, "Disctrict": "South Delhi"},
    {"Area": "Talimabad", "Pincode": 110062, "Disctrict": "South Delhi"},
    {"Area": "Tehkhand", "Pincode": 110020, "Disctrict": "South Delhi"},
    {"Area": "Tugalkabad", "Pincode": 110044, "Disctrict": "South Delhi"},
    {
      "Area": "Tugalkabad Railway Colony",
      "Pincode": 110044,
      "Disctrict": "South Delhi"
    },
    {"Area": "Zakir Nagar", "Pincode": 110025, "Disctrict": "South Delhi"},
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {
      "Area": "505 A B Workshop",
      "Pincode": 110010,
      "Disctrict": "South West Delhi"
    },
    {"Area": "A F Palam", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {
      "Area": "A F Rajokari",
      "Pincode": 110038,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Amberhai", "Pincode": 110075, "Disctrict": "South West Delhi"},
    {
      "Area": "Anand Niketan",
      "Pincode": 110021,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Ansari Nagar",
      "Pincode": 110029,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Aps Colony", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Arjungarh", "Pincode": 110047, "Disctrict": "South West Delhi"},
    {"Area": "Aya Nagar", "Pincode": 110047, "Disctrict": "South West Delhi"},
    {"Area": "Badusarai", "Pincode": 110071, "Disctrict": "South West Delhi"},
    {"Area": "Bagdola", "Pincode": 110077, "Disctrict": "South West Delhi"},
    {"Area": "Baprola", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {"Area": "Barthal", "Pincode": 110077, "Disctrict": "South West Delhi"},
    {"Area": "Bazar Road", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Bijwasan", "Pincode": 110061, "Disctrict": "South West Delhi"},
    {
      "Area": "C.S.K.M. School",
      "Pincode": 110074,
      "Disctrict": "South West Delhi"
    },
    {"Area": "C.V.D.", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {
      "Area": "Chanakya Puri",
      "Pincode": 110021,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Chandanhoola",
      "Pincode": 110074,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Chattarpur", "Pincode": 110074, "Disctrict": "South West Delhi"},
    {"Area": "Chhawla", "Pincode": 110071, "Disctrict": "South West Delhi"},
    {"Area": "COD", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {
      "Area": "CRPF Jharoda Kalan",
      "Pincode": 110072,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Dabri", "Pincode": 110045, "Disctrict": "South West Delhi"},
    {"Area": "Daulatpur", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {"Area": "DC Goyla", "Pincode": 110071, "Disctrict": "South West Delhi"},
    {"Area": "Delhi Cantt", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Dera", "Pincode": 110074, "Disctrict": "South West Delhi"},
    {"Area": "Dhansa", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {"Area": "Dhaula Kuan", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Dhulsiras", "Pincode": 110077, "Disctrict": "South West Delhi"},
    {
      "Area": "Dichaun Kalan",
      "Pincode": 110043,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Dindarpur", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {
      "Area": "District Court Complex Dwarka",
      "Pincode": 110075,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Dwarka Sec-6",
      "Pincode": 110075,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Fatehpur Beri",
      "Pincode": 110074,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Gadaipur", "Pincode": 110030, "Disctrict": "South West Delhi"},
    {"Area": "Galib Pur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {"Area": "Ghitorni", "Pincode": 110030, "Disctrict": "South West Delhi"},
    {"Area": "Ghuman Hera", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "Green Park Market",
      "Pincode": 110016,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Gurgaon Road",
      "Pincode": 110037,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Hauz Khas Market",
      "Pincode": 110016,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Hauz Khas", "Pincode": 110016, "Disctrict": "South West Delhi"},
    {"Area": "IGI Airport", "Pincode": 110037, "Disctrict": "South West Delhi"},
    {"Area": "Ignou", "Pincode": 110068, "Disctrict": "South West Delhi"},
    {"Area": "Indira Park", "Pincode": 110045, "Disctrict": "South West Delhi"},
    {"Area": "Issapur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "IT Hauz Khas",
      "Pincode": 110016,
      "Disctrict": "South West Delhi"
    },
    {"Area": "J.N.U.", "Pincode": 110067, "Disctrict": "South West Delhi"},
    {"Area": "Jafarpur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {"Area": "Jaunapur", "Pincode": 110047, "Disctrict": "South West Delhi"},
    {
      "Area": "Jharoda Kalan",
      "Pincode": 110072,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Jhatikara", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {
      "Area": "JNU New Campus",
      "Pincode": 110067,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Kair B.O", "Pincode": 110028, "Disctrict": "South West Delhi"},
    {"Area": "Kakrola", "Pincode": 110078, "Disctrict": "South West Delhi"},
    {"Area": "Kangan Heri", "Pincode": 110071, "Disctrict": "South West Delhi"},
    {"Area": "Kapashera .", "Pincode": 110097, "Disctrict": "South West Delhi"},
    {"Area": "Khaira B.O", "Pincode": 110028, "Disctrict": "South West Delhi"},
    {"Area": "Khera Dabur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "Kidwai Nagar East",
      "Pincode": 110023,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Kidwai Nagar West",
      "Pincode": 110023,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Kirby Place", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Lado Sarai", "Pincode": 110030, "Disctrict": "South West Delhi"},
    {
      "Area": "Laxmi Bai Nagar",
      "Pincode": 110023,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Mahipalpur", "Pincode": 110037, "Disctrict": "South West Delhi"},
    {
      "Area": "Maidan Garhi",
      "Pincode": 110068,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Malcha Marg", "Pincode": 110021, "Disctrict": "South West Delhi"},
    {"Area": "Malik Pur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {"Area": "Mandi", "Pincode": 110047, "Disctrict": "South West Delhi"},
    {"Area": "Masood Pur", "Pincode": 110070, "Disctrict": "South West Delhi"},
    {"Area": "Maya Puri", "Pincode": 110064, "Disctrict": "South West Delhi"},
    {
      "Area": "Mayapuri Shopping Centre",
      "Pincode": 110064,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Mehrauli", "Pincode": 110030, "Disctrict": "South West Delhi"},
    {"Area": "Mitraon", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {"Area": "Moti Bagh", "Pincode": 110021, "Disctrict": "South West Delhi"},
    {
      "Area": "Mundela Kalan",
      "Pincode": 110073,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Munirka", "Pincode": 110067, "Disctrict": "South West Delhi"},
    {
      "Area": "N.S.I.T. Dwarka",
      "Pincode": 110078,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Najafgarh", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {"Area": "Nanak Pura", "Pincode": 110021, "Disctrict": "South West Delhi"},
    {
      "Area": "Nangal Dewat",
      "Pincode": 110037,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Nangal Raya", "Pincode": 110046, "Disctrict": "South West Delhi"},
    {
      "Area": "Naraina Industrial Estate",
      "Pincode": 110028,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Naraina Village",
      "Pincode": 110028,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Nasirpur", "Pincode": 110045, "Disctrict": "South West Delhi"},
    {
      "Area": "Netaji Nagar",
      "Pincode": 110023,
      "Disctrict": "South West Delhi"
    },
    {"Area": "NIE Campus", "Pincode": 110016, "Disctrict": "South West Delhi"},
    {
      "Area": "Palam Airport",
      "Pincode": 110037,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Palam Village",
      "Pincode": 110045,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Pandwala Kalan",
      "Pincode": 110043,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Papravat", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {
      "Area": "Paryavaran Complex",
      "Pincode": 110030,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Pinto Park", "Pincode": 110010, "Disctrict": "South West Delhi"},
    {"Area": "Quazipur", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "R K Puram (Main)",
      "Pincode": 110066,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-1",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-12",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-3",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-4",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-5",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect-8",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sect7",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram Sector - 6 Postal SB",
      "Pincode": 110022,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R K Puram West",
      "Pincode": 110066,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "R R Hospital",
      "Pincode": 110010,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Raj Nagar - II",
      "Pincode": 110077,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Rajokari", "Pincode": 110038, "Disctrict": "South West Delhi"},
    {"Area": "Raota", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "Rewla Khanpur",
      "Pincode": 110043,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Safdarjung Enclave",
      "Pincode": 110029,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Sagarpur", "Pincode": 110046, "Disctrict": "South West Delhi"},
    {
      "Area": "Sanjay Colony Bhati Mines",
      "Pincode": 110074,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Sarojini Nagar",
      "Pincode": 110023,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Satbari", "Pincode": 110074, "Disctrict": "South West Delhi"},
    {
      "Area": "Sawan Public School",
      "Pincode": 110074,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Shahbad Mohammadpur",
      "Pincode": 110061,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Signal Enclave",
      "Pincode": 110010,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "South Delhi Campus",
      "Pincode": 110021,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Station Road",
      "Pincode": 110010,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Subroto Park",
      "Pincode": 110010,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Sultanpur", "Pincode": 110030, "Disctrict": "South West Delhi"},
    {"Area": "Surehra", "Pincode": 110043, "Disctrict": "South West Delhi"},
    {
      "Area": "T B Hospital",
      "Pincode": 110030,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Technology Bhawan",
      "Pincode": 110016,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Tilangpur Kotla",
      "Pincode": 110043,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Ujwa", "Pincode": 110073, "Disctrict": "South West Delhi"},
    {
      "Area": "Vasant Kunj Pkt-A",
      "Pincode": 110070,
      "Disctrict": "South West Delhi"
    },
    {"Area": "Vasant Kunj", "Pincode": 110070, "Disctrict": "South West Delhi"},
    {
      "Area": "Vasant Vihar-1",
      "Pincode": 110057,
      "Disctrict": "South West Delhi"
    },
    {
      "Area": "Vasant Vihar-2",
      "Pincode": 110057,
      "Disctrict": "South West Delhi"
    },
    {"Area": "", "Pincode": "", "Disctrict": ""},
    {"Area": "Ashok Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Ashoka Park Extn.", "Pincode": 110026, "Disctrict": "West Delhi"},
    {"Area": "Bakkarwala", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Chand Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Chaukhandi", "Pincode": 110018, "Disctrict": "West Delhi"},
    {
      "Area": "D. K. Mohan Garden",
      "Pincode": 110059,
      "Disctrict": "West Delhi"
    },
    {"Area": "D.E.S.U. Colony", "Pincode": 110058, "Disctrict": "West Delhi"},
    {
      "Area": "Delhi Industrial Area",
      "Pincode": 110015,
      "Disctrict": "West Delhi"
    },
    {
      "Area": "Distt. Court Complex, Dwarka",
      "Pincode": 110078,
      "Disctrict": "West Delhi"
    },
    {"Area": "ESI", "Pincode": 110015, "Disctrict": "West Delhi"},
    {"Area": "Fateh Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "GGSIP University", "Pincode": 110078, "Disctrict": "West Delhi"},
    {
      "Area": "Hari Nagar BE Block",
      "Pincode": 110064,
      "Disctrict": "West Delhi"
    },
    {
      "Area": "Hari Nagar Dadb Block",
      "Pincode": 110064,
      "Disctrict": "West Delhi"
    },
    {"Area": "Hari Nagar", "Pincode": 110064, "Disctrict": "West Delhi"},
    {"Area": "Hastal Village", "Pincode": 110059, "Disctrict": "West Delhi"},
    {"Area": "Hirankudna", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Jail Road", "Pincode": 110058, "Disctrict": "West Delhi"},
    {"Area": "Janakpuri A-3", "Pincode": 110058, "Disctrict": "West Delhi"},
    {"Area": "Janakpuri B-1", "Pincode": 110058, "Disctrict": "West Delhi"},
    {"Area": "Janakpuri C-4", "Pincode": 110058, "Disctrict": "West Delhi"},
    {"Area": "Janta Market", "Pincode": 110027, "Disctrict": "West Delhi"},
    {"Area": "Jawala Heri", "Pincode": 110063, "Disctrict": "West Delhi"},
    {"Area": "Jeevan Park", "Pincode": 110059, "Disctrict": "West Delhi"},
    {"Area": "Jwala Puri", "Pincode": 110087, "Disctrict": "West Delhi"},
    {"Area": "Karam Pura", "Pincode": 110015, "Disctrict": "West Delhi"},
    {"Area": "Khyala Phase - I", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Khyala Phase - II", "Pincode": 110018, "Disctrict": "West Delhi"},
    {
      "Area": "L. M. Nagar Indl. Area",
      "Pincode": 110015,
      "Disctrict": "West Delhi"
    },
    {"Area": "M.B.S. Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {
      "Area": "Madipur Slum Quarter",
      "Pincode": 110063,
      "Disctrict": "West Delhi"
    },
    {"Area": "Madipur Village", "Pincode": 110063, "Disctrict": "West Delhi"},
    {"Area": "Mahabir Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Mansarover Garden", "Pincode": 110015, "Disctrict": "West Delhi"},
    {"Area": "Matiala", "Pincode": 110059, "Disctrict": "West Delhi"},
    {"Area": "Mundka", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "N.I.Area", "Pincode": 110015, "Disctrict": "West Delhi"},
    {"Area": "Nangloi - II", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Nangloi - III", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Nangloi", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Nilothi", "Pincode": 110041, "Disctrict": "West Delhi"},
    {
      "Area": "Palam Extn (Harijan Basti)",
      "Pincode": 110077,
      "Disctrict": "West Delhi"
    },
    {
      "Area": "Paschim Vihar B Block",
      "Pincode": 110063,
      "Disctrict": "West Delhi"
    },
    {"Area": "Paschim Vihar", "Pincode": 110063, "Disctrict": "West Delhi"},
    {"Area": "Peeragarhi", "Pincode": 110063, "Disctrict": "West Delhi"},
    {"Area": "Punjabi Bagh", "Pincode": 110026, "Disctrict": "West Delhi"},
    {
      "Area": "Punjabi Bagh Sec - III",
      "Pincode": 110026,
      "Disctrict": "West Delhi"
    },
    {
      "Area": "Rajouri Garden J-6",
      "Pincode": 110027,
      "Disctrict": "West Delhi"
    },
    {"Area": "Rajouri Market", "Pincode": 110027, "Disctrict": "West Delhi"},
    {"Area": "Ramesh Nagar", "Pincode": 110015, "Disctrict": "West Delhi"},
    {"Area": "Ranhola", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Shivaji Park", "Pincode": 110026, "Disctrict": "West Delhi"},
    {"Area": "Subhash Nagar", "Pincode": 110027, "Disctrict": "West Delhi"},
    {
      "Area": "Subhash Nagar West",
      "Pincode": 110027,
      "Disctrict": "West Delhi"
    },
    {"Area": "Sunder Vihar", "Pincode": 110087, "Disctrict": "West Delhi"},
    {"Area": "Tagore Garden", "Pincode": 110027, "Disctrict": "West Delhi"},
    {"Area": "Tikri Kalan", "Pincode": 110041, "Disctrict": "West Delhi"},
    {"Area": "Tilak Nagar East", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Tilak Nagar", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Uttam Nagar", "Pincode": 110059, "Disctrict": "West Delhi"},
    {"Area": "Vikas Puri", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Vishnu Garden", "Pincode": 110018, "Disctrict": "West Delhi"},
    {"Area": "Zakhira", "Pincode": 110015, "Disctrict": "West Delhi"}
  ];

  static var delhiDistricts = [
    "New Delhi",
    "North Delhi",
    "North West Delhi",
    "West Delhi",
    "South West Delhi",
    "South Delhi",
    "South East Delhi",
    "Central Delhi",
    "North East Delhi",
    "Shahdara",
    "East Delhi"
  ];
  static String firstName;
  static String lastName;
  static int age;
  static String phoneNumber;
  static String patientSex;
  Sex patientSexToBeSaved;
  static String address;
  static String markaz;
  static String pincode;
  static String selectedDistrict;
  static String selectedRevenueDistrict;
  static String city;
  static String state;
  static String country;
  static String hospitalGivenID;
  static String hospitalID;
  static String hospitalName;
  static bool isResidentOfDelhi;
  static bool isHealthCareWorker;
  static String fatherOrHusbandFirstName;
  static String fatherOrHusbandLastName;
  static String emergencyContactRelation;
  static String emergencyContactFirstNametest;
  static String emergencyContactLastName;
  static String emergencyContactPhoneNumber;

  bool markazRadioGroupValue;
  markazRadioTapped(bool value) {
    setState(() {
      markazRadioGroupValue = value;
    });
  }

  isResidentRadioTapped(bool value) {
    setState(() {
      isResidentOfDelhi = value;
    });
  }

  healhcareWorkerRadioTapped(bool value) {
    setState(() {
      isHealthCareWorker = value;
    });
  }

  patientSexChanged(String value) {
    setState(() {
      patientSex = value;
      if (patientSex == "Male") {
        patientSexToBeSaved = Sex.Male;
      } else if (patientSex == "Female") {
        patientSexToBeSaved = Sex.Female;
      } else if (patientSex == "Other") {
        patientSexToBeSaved = Sex.Other;
      }
    });
  }

  FullAddress patientAddress;
  DelhiSpecificDetails details = DelhiSpecificDetails();

  changePatientSex(String newSex) {
    setState(() {
      patientSex = newSex;
    });
  }

  changeIsResidentOfDelhi(bool newStatus) {
    setState(() {
      isResidentOfDelhi = newStatus;
    });
  }

  changeHealthWorkerStatus(bool newStatus) {
    setState(() {
      isHealthCareWorker = newStatus;
    });
  }

  static String newPatientID;
  @override
  AddPatient() async {
    print("AddPatient called");
    patientAddress = FullAddress(
      address: address,
      city: city,
      state: state,
      zipcode: pincode,
      country: country,
    );

    Patient patientToBeCrated = Patient(
        Firstname: firstName,
        LastName: lastName,
        age: age,
        fullAddress: patientAddress,
        id: newPatientID,
        idGivenByHospital: hospitalGivenID,
        currentLocation: 2,
       
        hospitalID:
            Provider.of<Hospitals>(context, listen: false).fetchedHospital.id,
        sex: patientSexToBeSaved,
        covidStatusString: "NP-1",
        ventilatorUsed: false,
        events: [],
        vitals: [],
        tests: [],
        notes:[],
        phoneNumber: phoneNumber,
        emergencyContactFirstName: emergencyContactFirstNametest,
        emergencyContactLastName: emergencyContactLastName,
        emergencyContactPhoneNumber: emergencyContactPhoneNumber,
        emergencyContactRelation: emergencyContactRelation
        // travelHistory: [],
        );
    try {
      await Provider.of<Patients>(context, listen: false)
          .addPatient(patientToBeCrated);

      await Provider.of<Hospitals>(context, listen: false)
          .addPatientToTheHospital();

      // await Provider.of<Patients>(context, listen: false).addPatientEvent();
      //   Navigator.pop(context);
    } catch (error) {}
  }

  AddPatientAndScreen() async {
    print("AddPatientAndScreen called");
    patientAddress = FullAddress(
      address: address,
      city: city,
      state: state,
      zipcode: pincode,
      country: country,
    );

    Patient patientToBeCrated = Patient(
        Firstname: firstName,
        LastName: lastName,
        age: age,
        fullAddress: patientAddress,
        id: newPatientID,
        idGivenByHospital: hospitalGivenID,
        currentLocation: 2,
       
        hospitalID:
            Provider.of<Hospitals>(context, listen: false).fetchedHospital.id,
        sex: patientSexToBeSaved,
        covidStatusString: "NP-1",
        ventilatorUsed: false,
        events: [],
        vitals: [],
        tests: [],
        notes:[],
        phoneNumber: phoneNumber,
        emergencyContactFirstName: emergencyContactFirstNametest,
        emergencyContactLastName: emergencyContactLastName,
        emergencyContactPhoneNumber: emergencyContactLastName,
        emergencyContactRelation: emergencyContactRelation
        // travelHistory: [],
        );
    try {
      await Provider.of<Patients>(context, listen: false)
          .addPatient(patientToBeCrated);

      await Provider.of<Patients>(context, listen: false)
          .fetchPatientsListFromServer(
              Provider.of<Hospitals>(context, listen: false)
                  .fetchedHospital
                  .id,[]);

      await Provider.of<Patients>(context, listen: false)
          .selectPatient(patientToBeCrated.id);

      await Provider.of<Hospitals>(context, listen: false)
          .addPatientToTheHospital();

      // await Provider.of<Patients>(context, listen: false).addPatientEvent();
      //   Navigator.pop(context);
    } catch (error) {}
  }

  void initState() {
    firstName = "";
    patientSex = null;
    // TODO: implement initState
    newPatientID = randomAlphaNumeric(10);

    super.initState();
  }

  static findZipCodeDetails() {
    var a = delhiZipCodes.where((element) => element['Pincode'] == pincode);
    print(a);
    return a;
  }

  final formKey2 = GlobalKey<FormState>();

  _pickImage(Patient patient) async {
    patient.pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted) setState(() {});
  }

  savePatientAndGoBack() async {
    print("SavePatientAndGoBack called");
    if (formKey2.currentState.validate()) {
      formKey2.currentState.save();
      await AddPatient();
      Navigator.of(context).pop(true);
    }
  }

  savePatientAndGoToScreening() async {
    print("SavePatientAndGotoScreening called");

    // if (formKey2.currentState.validate()) {
    //   formKey2.currentState.save();
    //   await AddPatient();

    if (formKey2.currentState.validate()) {
      formKey2.currentState.save();
      await AddPatientAndScreen();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => PatientScreeningScreen()));
    }
  }

  int currentStep = 0;
  bool complete = false;

  goTo(int step) {
    print("gotto step $currentStep $step");
    setState(() {
      currentStep = step;
    });
    print("gotto step $currentStep $step");
  }

  next() {
    print("next called");
    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [];

    Patient newPatient = Provider.of<Patients>(context).newPatient;

    print("HOSPITAL IS" +
        Provider.of<Hospitals>(context, listen: true)
            .fetchedHospital
            .hospitalName);
    setState() {
      hospitalName = Provider.of<Hospitals>(context, listen: true)
          .fetchedHospital
          .hospitalName;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Patient Registration',
          style: Theme.of(context).textTheme.caption,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 20,
              child: SingleChildScrollView(
                //    height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey2,
                    child: Theme(
                        data: ThemeData(
                            primaryColor: Color.fromRGBO(35, 71, 162, 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("1. Patient Information",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Autogenerated patient ID:    ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    newPatientID,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Is the patient a doctor/nurse?",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      SizedBox(width: 10),
                                      Row(
                                        children: <Widget>[
                                          Text("Yes"),
                                          Radio(
                                            value: true,
                                            groupValue: isHealthCareWorker,
                                            onChanged: (value) =>
                                                healhcareWorkerRadioTapped(
                                                    value),
                                          ),
                                          SizedBox(width: 20),
                                          Text("No"),
                                          Radio(
                                            value: false,
                                            groupValue: isHealthCareWorker,
                                            onChanged: (value) =>
                                                healhcareWorkerRadioTapped(
                                                    value),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: <Widget>[
                            //       Container(
                            //         width: 200,
                            //         child: Text("Markaz",
                            //             style: TextStyle(
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.normal)),
                            //       ),
                            //       Row(
                            //         children: <Widget>[
                            //           Text("Yes"),
                            //           Radio(
                            //             value: true,
                            //             groupValue: markazRadioGroupValue,
                            //             onChanged: (value) =>
                            //                 markazRadioTapped(value),
                            //           ),
                            //           SizedBox(width: 20),
                            //           Text("No"),
                            //           Radio(
                            //             value: false,
                            //             groupValue: markazRadioGroupValue,
                            //             onChanged: (value) =>
                            //                 markazRadioTapped(value),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),

                            // ),
                            SizedBox(
                              height: 5,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  this.setState(() {
                                    hospitalGivenID = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "ID Given by hospital",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    hospitalGivenID = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  this.setState(() {
                                    firstName = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isAlpha(value) == false) {
                                    print("Here");
                                    return 'Names can contain only alphabets';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    firstName = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  this.setState(() {
                                    lastName = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isAlpha(value) == false) {
                                    print("Here");
                                    return 'Names can contain only alphabets';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    lastName = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Sex",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(width: 10),
                                  Row(
                                    children: <Widget>[
                                      Text("Male"),
                                      Radio(
                                        value: "Male",
                                        groupValue: patientSex,
                                        onChanged: (value) =>
                                            patientSexChanged(value),
                                      ),
                                      SizedBox(width: 20),
                                      Text("Female"),
                                      Radio(
                                        value: "Female",
                                        groupValue: patientSex,
                                        onChanged: (value) =>
                                            patientSexChanged(value),
                                      ),
                                      SizedBox(width: 20),
                                      Text("Other"),
                                      Radio(
                                        value: "Other",
                                        groupValue: patientSex,
                                        onChanged: (value) =>
                                            patientSexChanged(value),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                onChanged: (value) {
                                  this.setState(() {
                                    age = int.parse(value);
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isNumeric(value) == false) {
                                    return 'Age can only be a number';
                                  } else if (int.parse(value) > 120) {
                                    return ('Please enter a valid age');
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Age",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    age = int.parse(value);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                onChanged: (value) {
                                  this.setState(() {
                                    phoneNumber = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (value.length < 7 ||
                                      value.length > 12) {
                                    return 'Phone Number is either too short or too long';
                                  } else if (isNumeric(value) == false) {
                                    return 'Phone Number only allows numbers';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    phoneNumber = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("2. Patient Address",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: Container(
                            //       child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: <Widget>[
                            //       Container(
                            //         width: 200,
                            //         child: Text(
                            //             "Is the patient a resident of Delhi?",
                            //             style: TextStyle(
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.normal)),
                            //       ),
                            //       SizedBox(width: 10),
                            //       Row(
                            //         children: <Widget>[
                            //           Text("Yes"),
                            //           Radio(
                            //             value: true,
                            //             groupValue: isResidentOfDelhi,
                            //             onChanged: (value) =>
                            //                 isResidentRadioTapped(value),
                            //           ),
                            //           SizedBox(width: 20),
                            //           Text("No"),
                            //           Radio(
                            //             value: false,
                            //             groupValue: isResidentOfDelhi,
                            //             onChanged: (value) =>
                            //                 isResidentRadioTapped(value),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   )),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  this.setState(() {
                                    address = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Street, Area Address",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    address = value;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 6,
                                    child: TextFormField(
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                      textInputAction: TextInputAction.next,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                      onChanged: (String value) {
                                        this.setState(() {
                                          pincode = value;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        } else if (isNumeric(value) == false) {
                                          return 'Pincode can only have numbers';
                                        }
                                        return null;
                                      },
                                      //  style: Theme.of(context).textTheme.bodyText1,
                                      decoration: InputDecoration(
                                        labelText: "Pin Code",
                                        // hintText: "Event",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300])),
                                      ),
                                      onSaved: (String value) {
                                        this.setState(() {
                                          pincode = value;
                                        });
                                      },
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Flexible(
                                  //     flex: 2,
                                  //     child: FlatButton(
                                  //       onPressed: () {
                                  //         return findZipCodeDetails();
                                  //       },
                                  //       child: Text("Search"),
                                  //     )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: Row(
                            //     children: <Widget>[
                            //       Container(
                            //         width: 200,
                            //         child: Text("Choose District",
                            //             style: TextStyle(
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.normal)),
                            //       ),
                            //       Container(
                            //           child: DropdownButton<String>(
                            //         value: selectedDistrict,
                            //         hint: Text("Select District"),
                            //         items:
                            //             delhiDistricts.map((String district) {
                            //           return new DropdownMenuItem<String>(
                            //             value: district,
                            //             child: new Text(district),
                            //           );
                            //         }).toList(),
                            //         onChanged: (String value) {
                            //           this.setState(() {
                            //             selectedDistrict = value;
                            //           });
                            //         },
                            //       )),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(2.0),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: <Widget>[
                            //       Container(
                            //         width: 150,
                            //         child: Text("Choose Revenue District",
                            //             style: TextStyle(
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.normal)),
                            //       ),
                            //       DropdownButton<String>(
                            //         value: selectedRevenueDistrict,
                            //         hint: Text("Select Revenue District"),
                            //         items:
                            //             delhiDistricts.map((String district) {
                            //           return new DropdownMenuItem<String>(
                            //             value: district,
                            //             child: new Text(district),
                            //           );
                            //         }).toList(),
                            //         onChanged: (String value) {
                            //           this.setState(() {
                            //             selectedRevenueDistrict = value;
                            //           });
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  this.setState(() {
                                    city = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                // initialValue: "Delhi",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "City",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    city = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  this.setState(() {
                                    state = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                //    initialValue: "Delhi",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "State",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    state = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  this.setState(() {
                                    country = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                initialValue: "India",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Country",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    country = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("3. Emergency Contact",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Relation",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      SizedBox(width: 10),
                                      DropdownButton<String>(
                                        value: emergencyContactRelation,
                                        hint: Text("Select"),
                                        items: [
                                          "Father",
                                          "Mother",
                                          "Spouse",
                                          "Child"
                                        ].map((String selectedValue) {
                                          return new DropdownMenuItem<String>(
                                            value: selectedValue,
                                            child: Text(selectedValue),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          this.setState(() {
                                            emergencyContactRelation = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                onChanged: (value) {
                                  this.setState(() {
                                    emergencyContactFirstNametest = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isAlpha(value) == false) {
                                    return 'Names can only have alphabets in them';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Emergency Contact's First Name",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    emergencyContactFirstNametest = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                onChanged: (value) {
                                  this.setState(() {
                                    emergencyContactLastName = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isAlpha(value) == false) {
                                    return 'Names can only have alphabets in them';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Emergency Contact's Last Name",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    emergencyContactLastName = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                },
                                textInputAction: TextInputAction.next,
                                autovalidate: true,
                                onChanged: (value) {
                                  this.setState(() {
                                    emergencyContactPhoneNumber = value;
                                  });
                                },
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (isNumeric(value) == false) {
                                    return 'Phone Numbers can only have numbers in them';
                                  }
                                  return null;
                                },
                                //  style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  labelText: "Emergency Contact's Phone Number",
                                  // hintText: "Event",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300])),
                                ),
                                onSaved: (String value) {
                                  this.setState(() {
                                    emergencyContactPhoneNumber = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            MediaQuery.of(context).viewInsets.bottom == 0
                  ? Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            await savePatientAndGoBack();
                          },
                          color: Theme.of(context).accentColor,
                          child: Provider.of<Patients>(context, listen: true)
                                          .isAddingPatient ==
                                      false &&
                                  Provider.of<Hospitals>(context, listen: true)
                                          .isUpdating ==
                                      false
                              ? Text("SAVE & GO BACK",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith())
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                ),
                        ),
                      ],
                    ),

                    Container(
                      //  width: 200,
                      child: FlatButton(
                        onPressed: () async {
                          await savePatientAndGoToScreening();
                        },
                        color: Theme.of(context).accentColor,
                        child: Provider.of<Patients>(context, listen: true)
                                        .isAddingPatient ==
                                    false &&
                                Provider.of<Hospitals>(context, listen: true)
                                        .isUpdating ==
                                    false
                            ? Text("PROCEED TO SCREENING",
                                style: Theme.of(context).textTheme.caption)
                            : CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                      ),
                    ),
                    // FlatButton(
                    //   onPressed: () async {
                    //     await savePatientAndGoToScreening();
                    //   },
                    //   color: Theme.of(context).accentColor,
                    //   child: Text("START SCREENING",
                    //       style: Theme.of(context).textTheme.caption),
                    // ),
                  ],
                ),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
