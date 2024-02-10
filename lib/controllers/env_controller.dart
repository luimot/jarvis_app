import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EnvController extends GetxController {
  final String baseUrl = 'http://127.0.0.1:3000';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        'true', // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS"
  };
  var counter = 0.obs;
  Map<String, dynamic> requestData = {
    "latitude": 0,
    "longitude": 0,
    "elevation": 1400,
    "atmospheric_model_type": "standard_atmosphere",
    "atmospheric_model_file": "GFS",
    "date": "2024-01-01T00:00:00.000000"
  }.obs;

  Future<void> postData(Map<String, dynamic> requestData) async {
    try {
      var requestBody = jsonEncode(requestData);
      print('requestBody: $requestBody');
      final response = await http.post(
        Uri.parse('$baseUrl/environments'),
        headers: headers,
        body: requestBody,
      );
      if (response.statusCode == 200) {
        // Successfully created resource in the API
        print('Resource created successfully! ${response.body}');
      } else {
        print('Error creating resource. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating resource: $e');
    }
  }

  void increment() {
    counter++;
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl'));
      if (response.statusCode == 200) {
        // Parse the response or do whatever is needed with the data
        print('API Data: ${response.body}');
      } else {
        print(
            'Error fetching data from API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data from API: $e');
    }
  }

  Future<void> putData() async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl'),
        body: {'key': 'updatedValue'},
      );
      if (response.statusCode == 200) {
        // Successfully updated resource in the API
        print('Resource updated successfully! ${response.body}');
      } else {
        print('Error updating resource. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating resource: $e');
    }
  }

  Future<void> deleteData() async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl'));
      if (response.statusCode == 204) {
        // Successfully deleted resource in the API
        print('Resource deleted successfully!');
      } else {
        print('Error deleting resource. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting resource: $e');
    }
  }
}
