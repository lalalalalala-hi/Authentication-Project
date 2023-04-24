import 'package:facebook_auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FBUserInfo(
            userData: userData,
          ),
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

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
