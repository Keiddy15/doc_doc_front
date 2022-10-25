import 'dart:convert';
import 'package:doc_doc_front/environment.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  Future login(email, password) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}auth/login/'),
        headers: headers,
        body: body);
    return response;
  }

  Future register(email, password, age, fullName) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
      'fullName': fullName,
      'age': age,
    });
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}auth/register/'),
        headers: headers,
        body: body);
    return response;
  }
}
