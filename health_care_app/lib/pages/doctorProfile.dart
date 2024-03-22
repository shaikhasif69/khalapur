import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_care_app/models/UserModel.dart';
import 'package:health_care_app/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/DoctorModel.dart';

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;
  final String imagePath;
  const DoctorProfile({required this.doctor, required this.imagePath});
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late SharedPreferences prefs;
  bool isButtonDisabled = false;
  //   Future<void> checkAppointmentStatus() async {
  //   // Check if the appointment is already booked for the user
  //   // You can use AuthService or any other method to check this
  //   // Example:
  //   bool appointmentBooked = await AuthServices.bookAppointment();
  //   setState(() {
  //     isButtonDisabled = appointmentBooked;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _checkAppointmentStatus();
  }

  Future<void> _checkAppointmentStatus() async {
    try {
      bool appointmentBooked = await AuthServices.isAppointmentBookedForDoctor(widget.doctor.id);
      setState(() {
        isButtonDisabled = appointmentBooked;
      });
    } catch (e) {
      print('Error checking appointment status: $e');
    }
  }

  List<String> alternateImages = [
    'assets/doc1.png',
    'assets/doc2.png',
    'assets/doc3.png',
    'assets/doc4.png',
    'assets/doc5.png',
  ];

  _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user;

    String someDoctorShit =
        "As a doctor, my mission is to provide compassionate and comprehensive care to my patients, emphasizing a holistic approach to health and wellness. With a commitment to lifelong learning and staying updated with the latest advancements in medical science.";
    String doctorAdd =
        "Dr. Sameer Shah, XYZ Clinic, 567 Gandhi Road, Vile Parle West, Mumbai, Maharashtra, India, 400056";
    String doctorId = widget.doctor.id;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          Doctor doctor = widget.doctor;
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left_sharp,
                      color: Colors.indigo,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover, // Adjust the fit as per your requirement
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  doctor.doctorName,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  doctor.doctorQualification,
                  style: GoogleFonts.lato(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 5; i++)
                      Icon(
                        Icons.star_rounded,
                        color: Colors.indigoAccent,
                        size: 30,
                      ),
                    if (5 - 2 > 0)
                      for (var i = 0; i < 5 - 4; i++)
                        Icon(
                          Icons.star_rounded,
                          color: Colors.black12,
                          size: 30,
                        ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  padding: EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  child: Text(
                    someDoctorShit,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.place_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Text(
                          doctorAdd,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.phone),
                      SizedBox(
                        width: 11,
                      ),
                      TextButton(
                        onPressed: () =>
                            _launchCaller("tel:" + doctor.doctorMobileNo),
                        child: Text(
                          doctor.doctorMobileNo.toString(),
                          style: GoogleFonts.lato(
                              fontSize: 16, color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.access_time_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Working Hours',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Text(
                        'Today: ',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "10:00 AM" + " - " + "01:00 PM",
                        style: GoogleFonts.lato(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: isButtonDisabled
                        ? null // Disable button if appointment is already booked
                        : () async {
                            try {
                              await AuthServices.bookAppointment(
                                widget.doctor.id,
                                "whatever date it be",
                                "get lost",
                                "pending"
                              );
                              setState(() {
                                isButtonDisabled =
                                    true; // Disable button after successful booking
                              });
                            } catch (e) {
                              // Handle errors
                              print('Error: $e');
                              // Show a snackbar or any other error handling mechanism
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to book appointment. Please try again.'),
                                ),
                              );
                            }
                          },
                    child: Text(
                      'Book an Appointment',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
