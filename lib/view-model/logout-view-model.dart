import 'package:facebook_auth/view/login_screen.dart';
import 'package:flutter/material.dart';

class LogoutViewModel {
  Future<void> logout(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
