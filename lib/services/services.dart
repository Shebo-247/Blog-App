import 'dart:convert';

import 'package:http/http.dart' as http;

class Services {
  static const String _baseUrl = 'http://192.168.1.4:5000';

  Future get(endpoint) async {
    String url = _baseUrl + endpoint;

    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201)
      return jsonDecode(response.body);
  }

  Future<http.Response> post(endpoint, Map<String, String> body) async {
    String url = _baseUrl + endpoint;

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    return response;
  }
}
