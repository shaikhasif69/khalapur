import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<bool> login({required String email, required String password}) async {
    final Uri apiUrl = Uri.parse('https://yourapi.com/auth/login');
    final Map<String, String> body = {'email': email, 'password': password};

    final response = await http.post(apiUrl, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final bool isLoggedIn = jsonResponse['isLoggedIn'];

      return isLoggedIn;
    } else {
      throw Exception('Failed to login');
    }
  }
}
