import 'dart:convert';
import 'dart:developer';
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

  Future<List<Posting>> getPostings() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/get-posting"));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        return data.map((json) => Posting.fromJson(json)).toList();
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      log('Failed to load postings: $e');
      throw Exception("Failed to load postings: $e");
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
}
