// auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiKey = 'AIzaSyB_n1_uHwaWw8Qk5KLB_cppwjOWAgMJgRE';

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User signed up successfully: ${response.body}');
      } else {
        print('Error signing up: ${response.body}');
      }
    } catch (error) {
      print('Error signing up: $error');
    }
  }
}

// Example usage
void main() {
  final authService = AuthService();
  authService.signUp('user@example.com', 'password123');
}