import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HomeServices {
  final String apiUrl =
      'http://localhost:5000/ai'; // Replace with your API endpoint

  Future<dynamic> getAdvice(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: json.encode({'data': data}), // Encode the data to JSON
      );

      if (response.statusCode == 200) {
        // If the server returns an OK response, parse the JSON
        return json.decode(response.body);
      } else {
        // If the server does not return a 200 response, throw an error
        throw Exception('Failed to load advice: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      log('Error occurred: $error');
      throw Exception('Error occurred: $error');
    }
  }
}
