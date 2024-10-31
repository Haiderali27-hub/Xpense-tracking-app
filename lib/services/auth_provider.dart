import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId; // Add this line to store the user ID

  String? get token => _token;
  String? get currentUserId => _userId; // Add getter for user ID

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userId = prefs.getString('userId'); // Load user ID
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await AuthService().login(email, password);
    if (response.containsKey('token')) {
      _token = response['token'];
      _userId = response['id']; // Add this line to save the user ID
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!); // Store user ID
      notifyListeners();
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await AuthService().register(username, email, password);
    if (response.containsKey('token')) {
      _token = response['token'];
      _userId = response['id']; // Add this line to save the user ID
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('userId', _userId!); // Store user ID
      notifyListeners();
    } else {
      // Handle error
      throw Exception("Registration failed: ${response['message']}");
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null; // Clear user ID
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId'); // Remove user ID
    notifyListeners();
  }
}
