import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({super.key});

  @override
  _EnvironmentPageState createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController altitudeController = TextEditingController();
  String selectedModelType = "standard_atmosphere";
  String selectedModelFile = "GFS";
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2022, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      currentTime: selectedDate,
      locale: LocaleType.en,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void makePostRequest() async {
    var url = Uri.parse('https://example.com/api/your_endpoint');

    try {
      Map<String, dynamic> requestData = {
        "latitude": double.parse(latitudeController.text),
        "longitude": double.parse(longitudeController.text),
        "elevation": double.parse(altitudeController.text),
        "atmospheric_model_type": selectedModelType,
        "atmospheric_model_file": selectedModelFile,
        "date": selectedDate.toIso8601String(),
      };

      var requestBody = jsonEncode(requestData);

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP POST Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: latitudeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Latitude'),
            ),
            TextField(
              controller: longitudeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Longitude'),
            ),
            TextField(
              controller: altitudeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Altitude'),
            ),
            DropdownButtonFormField(
              value: selectedModelType,
              onChanged: (value) {
                setState(() {
                  selectedModelType = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'standard_atmosphere',
                  child: Text('Standard Atmosphere'),
                ),
                DropdownMenuItem(
                  value: 'custom_atmosphere',
                  child: Text('Custom Atmosphere'),
                ),
              ],
              decoration: InputDecoration(labelText: 'Atmospheric Model Type'),
            ),
            DropdownButtonFormField(
              value: selectedModelFile,
              onChanged: (value) {
                setState(() {
                  selectedModelFile = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'GFS',
                  child: Text('GFS'),
                ),
                DropdownMenuItem(
                  value: 'ECMWF',
                  child: Text('ECMWF'),
                ),
              ],
              decoration: InputDecoration(labelText: 'Atmospheric Model File'),
            ),
            Row(
              children: [
                Text('Date: ${selectedDate.toLocal()}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: makePostRequest,
              child: Text('Send POST Request'),
            ),
          ],
        ),
      ),
    );
  }
}
