import 'dart:convert';
import 'package:http/http.dart' as http;

class ListingApiClient {
  static const _baseUrl = 'http://interview.advisoryapps.com/index.php';
  ListingApiClient();

  Future<Map<String, dynamic>> getListing(String id, String token) async {
    final url = Uri.parse('$_baseUrl/listing?id=$id&token=$token');
    final response = await http.get(url);
    final body = response.body;
    final Map<String, dynamic> responseBody = jsonDecode(body);
    return Map<String, dynamic>.from(responseBody);
  }
}
