import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

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
