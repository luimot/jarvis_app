import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jarvis_app/controllers/env_controller.dart';

class Environment extends StatefulWidget {
  const Environment({super.key});

  @override
  _EnvironmentState createState() => _EnvironmentState();
}

class _EnvironmentState extends State<Environment> {
  final EnvController envController = Get.put(EnvController());

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController altitudeController = TextEditingController();
  String selectedModelType = "standard_atmosphere";
  String selectedModelFile = "GFS";
  DateTime selectedDate = DateTime.now();

  Map<String, dynamic> requestData = {};

  Future<void> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // adjust as needed
            hintColor: Colors.blueAccent, // adjust as needed
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _updateRequestData();
      });
    }
  }

  void simulate() async {
    envController.postData(requestData);
  }

  void _updateRequestData() {
    requestData = {
      "latitude": double.tryParse(latitudeController.text) ?? 0.0,
      "longitude": double.tryParse(longitudeController.text) ?? 0.0,
      "elevation": double.tryParse(altitudeController.text) ?? 0.0,
      "atmospheric_model_type": selectedModelType,
      "atmospheric_model_file": selectedModelFile,
      "date": selectedDate.toIso8601String(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: latitudeController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            TextField(
              controller: longitudeController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
            TextField(
              controller: altitudeController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Altitude'),
            ),
            DropdownButtonFormField(
              value: selectedModelType,
              onChanged: (value) {
                setState(() {
                  selectedModelType = value!;
                  _updateRequestData();
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'standard_atmosphere',
                  child: Text('Standard Atmosphere'),
                ),
                DropdownMenuItem(
                  value: 'custom_atmosphere',
                  child: Text('Custom Atmosphere'),
                ),
              ],
              decoration:
                  const InputDecoration(labelText: 'Atmospheric Model Type'),
            ),
            DropdownButtonFormField(
              value: selectedModelFile,
              onChanged: (value) {
                setState(() {
                  selectedModelFile = value!;
                  _updateRequestData();
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'GFS',
                  child: Text('GFS'),
                ),
                DropdownMenuItem(
                  value: 'ECMWF',
                  child: Text('ECMWF'),
                ),
              ],
              decoration:
                  const InputDecoration(labelText: 'Atmospheric Model File'),
            ),
            Row(
              children: [
                Text('Date: ${selectedDate.toUtc()} (UTC)'),
                const Padding(padding: EdgeInsets.only(top: 100, left: 20)),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: simulate,
              child: const Text('Simulate'),
            ),
          ],
        ),
      ),
    );
  }
}
