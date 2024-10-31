import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fashion_ai/constants/constants.dart';
import 'package:fashion_ai/models/response.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  final String apiUrl = ApiUrl.baseUrl; // Replace with your API endpoint

  /// Uploads an image and returns the outfit details.
  Future<Map<String, dynamic>> uploadImage(
      File imageFile, String userId) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${apiUrl}upload-image'),
    );

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
    request.fields['user_id'] = userId;

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        log("call ended");

        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  /// Posts a query to the AI stylist and retrieves a suggestion.
  Future<dynamic> aiPost(String userId, String context, String question) async {
    log('AI request: $question');
    final response = await http.post(
      Uri.parse('$apiUrl/ai-post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'name': userId, 'context': context, 'question': question}),
    );
    log('AI response: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      Response res = Response.fromJson(responseBody);
      return res;
    } else {
      throw Exception('Failed to get AI suggestion: ${response.statusCode}');
    }
  }
}
