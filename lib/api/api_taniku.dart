import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taniku/models/tutorial_model.dart';
import 'package:taniku/models/marketprice_model.dart';
import 'package:taniku/models/obat_model.dart';
import 'package:taniku/models/postingan_model.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<List<Tutorial>> getTutorials() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/get-tutorial"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((json) => Tutorial.fromJson(json)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load tutorials: $e");
    }
  }

  Future<List<MarketPrice>> getMarket() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/get-market"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((json) => MarketPrice.fromJson(json)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load market prices: $e");
    }
  }

  Future<List<Obat>> getObats() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/get-obat"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((json) => Obat.fromJson(json)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load obats: $e");
    }
  }

  Future<List<Postingan>> getPostingan() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/get-post"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((json) => Postingan.fromJson(json)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load postingans: $e");
    }
  }

  Future<Map<String, dynamic>> search(String query) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/api/search?query=$query"));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['data'];
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to search: $e");
    }
  }

  Future<Map<String, dynamic>> createPost({
    required String idUser,
    required String deskripsi,
    required String displayname,
    required String photoUserUrl,
    required String gambarPostingan,
    int? like,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/create-post'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_user': idUser,
          'deskripsi': deskripsi,
          'displayname': displayname,
          'photo_user_url': photoUserUrl,
          'gambar_postingan': gambarPostingan,
          'like': like,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['data'];
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
