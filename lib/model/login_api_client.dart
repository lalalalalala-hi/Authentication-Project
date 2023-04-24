import 'dart:convert';

import 'package:facebook_auth/model/user.dart';
import 'package:http/http.dart' as http;

class LoginApiClient extends User {
  static const _baseUrl = 'http://interview.advisoryapps.com/index.php';
  LoginApiClient({required super.email, required super.password});

  Future<Map<String, dynamic>> login() async {
    final url = Uri.parse('$_baseUrl/login');
    final response =
        await http.post(url, body: {'email': email, 'password': password});
    final body = response.body;
    final Map<String, dynamic> responseBody = jsonDecode(body);
    return Map<String, dynamic>.from(responseBody);
  }
}
