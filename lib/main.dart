import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/env_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GetX Counter Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    'Contador: ${counterController.counter}',
                    style: const TextStyle(fontSize: 24),
                  )),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  counterController.increment();
                },
                child: const Text('Incrementar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
