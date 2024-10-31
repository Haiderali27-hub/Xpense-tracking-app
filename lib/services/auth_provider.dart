import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await AuthService().login(email, password);
    if (response.containsKey('token')) {
      _token = response['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      notifyListeners();
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await AuthService().register(username, email, password);
    if (response.containsKey('token')) {
      _token = response['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      notifyListeners();
    } else {
      // Handle error
      throw Exception("Registration failed: ${response['message']}");
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
