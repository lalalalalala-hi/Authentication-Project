import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutViewModel {
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('id');
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  void dispose() {}
}
