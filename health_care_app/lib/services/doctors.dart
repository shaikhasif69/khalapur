import 'package:geolocator/geolocator.dart';
import 'package:health_care_app/models/DoctorModel.dart';
import 'package:health_care_app/models/medical.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '';
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
      var response = await http.get(
        Uri.parse(
          "${AppConstants.IP}/patient/get-health-records/${prefs.getString('userId')}",
        ),
      );
      print("good");
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body);
        List<MedicalReport> dataList = [];
        if (data.isNotEmpty) {
          for (var element in data) {
            dataList.add(MedicalReport.fromJson(element));
          }
        }

        print(dataList.length);
        return dataList;
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

  static Future<String> getReportExplanation(data1) async {
    try {
      print(data1);
      var response = await http.post(
        Uri.parse(
          "${AppConstants.DjangoIP}/report_explanation/",
        ),

        body: {"data": jsonEncode(data1)},
        // headers: {"Content-Type": "application/json"},
      );
      var data = await response.body;

      final result = jsonDecode(data);
      print("Data here: " + result.toString());

      return result["output_text"];
    } catch (e) {
      print(e);
      return "fail";
    }
  }
}
