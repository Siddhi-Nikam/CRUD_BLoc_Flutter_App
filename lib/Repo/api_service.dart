import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "http://10.0.3.87:3000/api/users";

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getUsers"));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return []; // ✅ Return empty list on error
      }
    } catch (e) {
      print("Exception: $e");
      return []; // ✅ Return empty list if API call fails
    }
  }

  Future<Map<String, dynamic>> getUserById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/getUserById/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('User not found');
    }
  }

  Future<Map<String, dynamic>> addUser(String name, String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl//createUser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email}),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<Map<String, dynamic>> updateUser(
      String userId, String name, String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateUser/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/deleteUser/$userId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
