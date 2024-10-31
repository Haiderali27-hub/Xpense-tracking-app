import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      'http://10.0.2.2:3000/auth'; // Use the emulator's address

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    // Handle the response
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log in: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'username': username, 'email': email, 'password': password}),
    );

    // Handle the response
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
