import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserModel.dart';

class AuthServices {
  static const String userIdKey = 'userId';
  static const String userNameKey = 'UserName';
  static const String userEmailKey = 'userEmail';
  static const String userWeightKey = 'userWeight';
  static const String userDissKey = 'userDiss';
  static const String userBloodKey = 'userBook';
  static const String userOtherDisKey = 'userOtherDis';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String bookedDoctorsKey = 'bookedDoctors';
  static Future<UserModel?> loginUser(String email, String password) async {
    try {
      final String apiUrl = 'http://192.168.119.85:4000/patient/login';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'patientEmail': email,
          'patientPassword': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print("m i lovable? ");
        //  Store user information in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(userIdKey, userData['_id']);
        prefs.setString(userBloodKey, userData['bloodGroup']);
        prefs.setString(userNameKey, userData['patientName']);
        prefs.setString(userEmailKey, userData['patientEmail']);
        prefs.setString(userWeightKey, userData['weight']);
        prefs.setString(userDissKey, userData['disability']);
        prefs.setString(userOtherDisKey, userData['otherDisease']);
        prefs.setString(userBloodKey, userData['bloodGroup']);
        
        prefs.setBool(isLoggedInKey, true);
        print("m i lovable? ");
        return UserModel(
          id: userData['_id'],
          patientName: userData['patientName'],
          patientEmail: userData['patientEmail'],
          patientMobileNo: userData['patientMobileNo'],
          patientPassword: userData['patientPassword'],
          weight: userData['weight'],
          disability: userData['disability'],
          geneticDisorder: userData['geneticDisorder'],
          bloodGroup: userData['bloodGroup'],
          otherDisease: userData['otherDisease'],
          createdDate: DateTime.parse(userData['createdDate']),
        );
      } else {
        return null; // Return null if login fails
      }
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<void> bookAppointment(String doctorId, String appointmentDate,
      String startTime, String endTime) async {
    String? userId = await getUserId();
    if (userId == null) {
      throw Exception('User ID not found');
    }
    final apiUrl = 'http://192.168.119.85:4000/appointment/add-appointment';

    final requestBody = {
      'doctorId': doctorId,
      'patientId': userId, // Assuming id is the user's ID in your UserModel
      'appointmentDate': appointmentDate,
      'appointmentStartTime': startTime,
      'appointmentEndTime': endTime,
      'appointmentStatus': 'pending',
    };

    print("tis is the request body: " + requestBody.toString());

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> bookedDoctors =
          prefs.getStringList(bookedDoctorsKey)?.toSet() ?? {};
      bookedDoctors.add(doctorId);
      prefs.setStringList(bookedDoctorsKey, bookedDoctors.toList());
      print('Appointment booked successfully');
    } else {
      print('Failed to book appointment');
      throw Exception('Failed to book appointment');
    }
  }

  static Future<bool> isAppointmentBookedForDoctor(String doctorId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> bookedDoctors =
        prefs.getStringList(bookedDoctorsKey)?.toSet() ?? {};
    return bookedDoctors.contains(doctorId);
  }
}
