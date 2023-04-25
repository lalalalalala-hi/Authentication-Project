import 'package:flutter/material.dart';
import 'package:facebook_auth/model/user.dart';
import 'package:facebook_auth/model/login_api_client.dart';
import 'package:facebook_auth/view/listing-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    final user = User(email: email, password: password);
    final apiClient =
        LoginApiClient(email: user.email, password: user.password);

    final Map<String, dynamic> json = await apiClient.login();
    final id = json['id'].toString();
    final token = json['token'];
    final status = json['status'];
    final code = json['status']['code'];

    debugPrint('Id: $id');
    debugPrint('Token: $token');
    debugPrint('Code: $code');
    debugPrint('Status: $status');

    if (code == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('id', id);
      await prefs.setString('token', token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListPage(id: id, token: token),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
    }
  }
}
