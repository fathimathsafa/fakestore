import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String loginEndpoint = '/auth/login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$loginEndpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'success': true,
          'token': data['token'],
          'message': 'Login successful',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'token': null,
          'message': 'Login failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'token': null,
        'message': 'Network error: $e',
        'data': null,
      };
    }
  }
} 