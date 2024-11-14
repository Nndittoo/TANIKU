import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://your-laravel-app.com/api/users'));

    if (response.statusCode == 200) {
      List users = json.decode(response.body);
      print(users);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
