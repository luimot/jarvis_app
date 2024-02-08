import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.example.com/data'));
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

  Future<void> postData() async {
    try {
      final response = await http.post(
        Uri.parse('https://api.example.com/data'),
        body: {'key': 'value'},
      );
      if (response.statusCode == 201) {
        // Successfully created resource in the API
        print('Resource created successfully! ${response.body}');
      } else {
        print('Error creating resource. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating resource: $e');
    }
  }

  Future<void> putData() async {
    try {
      final response = await http.put(
        Uri.parse('https://api.example.com/data/1'),
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
      final response =
          await http.delete(Uri.parse('https://api.example.com/data/1'));
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
