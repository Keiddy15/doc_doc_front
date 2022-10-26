import 'dart:convert';
import 'package:doc_doc_front/environment.dart';
import 'package:doc_doc_front/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {
  Future getUserByToken() async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(
        Uri.parse('${Environment.apiUrl}user/getUserByToken/$token'),
        headers: headers);
    return response;
  }

  Future updateUser(fullName, email, age) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode({
      'email': email,
      'fullName': fullName,
      'age': age,
    });
    final response = await http.put(
        Uri.parse('${Environment.apiUrl}user/update'),
        headers: headers,
        body: body);
    return response;
  }

  Future<List<UserModel>> getAllUsers() async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    List<UserModel> users = [];
    final response = await http
        .get(Uri.parse('${Environment.apiUrl}user/getAll'), headers: headers);
    final jsonDecode = json.decode(response.body);
    final arrayUsers = jsonDecode['users'] == null ? [] : jsonDecode['users'] as List;
    for (var user in arrayUsers!) {
      users.add(UserModel.fromJson(user));
    }
    return users;
  }
}
