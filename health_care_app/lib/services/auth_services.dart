import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/UserModel.dart';

class AuthServices {
  static Future<UserModel?> loginUser(String email, String password) async {
    final String apiUrl = 'your-api-url-for-get-user';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);

      // Store user information in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userData['id']);

      return UserModel(
        id: userData['id'],
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
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to login');
    }
  }
}
