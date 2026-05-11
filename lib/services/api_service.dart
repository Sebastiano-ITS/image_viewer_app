import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  Future<List<Photo>> getPhotos({String? name, String? sortBy, String? order}) async {
    final queryParameters = {
      if (name != null) 'name': name,
      if (sortBy != null) 'sortBy': sortBy,
      if (order != null) 'order': order,
    };

    final uri = Uri.parse('$baseUrl/photos').replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Photo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<void> scanFolder(String folderPath) async {
    final response = await http.post(
      Uri.parse('$baseUrl/scan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'folderPath': folderPath}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to scan folder');
    }
  }

  String getPhotoUrl(int id) {
    return '$baseUrl/photo/$id';
  }
}
