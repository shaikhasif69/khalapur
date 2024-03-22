import 'package:geolocator/geolocator.dart';
import 'package:health_care_app/models/medical.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/DoctorModel.dart';
import '../utils/app_constants.dart';

class Doctors {
  static Future<List<Doctor>> getAllDoctors() async {
    var response = await http.get(
      Uri.parse(
        "${AppConstants.IP}/doctor/get-all-doctors",
      ),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Doctor> doctors = data.map((json) => Doctor.fromJson(json)).toList();
      print("this is the doctors +++++++++ : " + doctors.toString());
      return doctors;
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load doctors');
    }
  }

  static Future<String> getAIChatBotdata(String data) async {
    try {
      print("${AppConstants.IP}/doctor-ai/");
      var response = await http.post(
        Uri.parse(
          "${AppConstants.IP}/doctor-ai/",
        ),
        body: {"patientData": "", "question": data},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['output_text'];
      } else {
        return "Some Internal Error Occured";
      }
    } catch (e) {
      print(e);
      return "Some Internal Error Occured";
    }
  }

  static Future<List<MedicalReport>> getAllMedicalReports() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      ;
      print(
        "${AppConstants.IP}/get-health-records/${prefs.getString('userId')}",
      );
      // print(prefs.getBool("isL"))
      var response = await http.post(
        Uri.parse(
          "${AppConstants.IP}/get-health-records/${prefs.getString('userId')}",
        ),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<dynamic> getTopRatedDoctors() async {
    var response = await http.get(
      Uri.parse(
        "${AppConstants.IP}/campaign/getLatest5Campaign",
      ),
      headers: {"Content-Type": "application/json"},
    );
    var data = await response.body;
    final result = jsonDecode(data);
    print("Data here: " + result);

    return result["data"];
  }
}
