import 'package:facebook_auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/fbuser-info-screen.dart';

class FBLoginViewModel extends ChangeNotifier {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  FBLoginViewModel() {
    _checkIfisLoggedIn();
  }

  Map<String, dynamic>? get userData => _userData;
  bool get checking => _checking;

  Future<void> _checkIfisLoggedIn() async {
    _accessToken = await FacebookAuth.instance.accessToken;
    _checking = false;
    if (_accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      final name = _userData!['name'];
      final email = _userData!['email'];
      final url = _userData!['picture']['data']['url'];
      print('name: ${name}');
      print('name: ${email}');
      print('name: ${url}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFBLoggedIn', true);
      await prefs.setString('FBname', name);
      await prefs.setString('FBemail', email);
      await prefs.setString('FBurl', url);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FBUserInfo(name: name, email: email, url: url),
        ),
      );
      print('login success');
    } else {
      print('FB status: ${result.status}');
      print('FB status message: ${result.message}');
    }
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFBLoggedIn', false);
    await prefs.remove('FBname');
    await prefs.remove('FBemail');
    await prefs.remove('FBurl');

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
