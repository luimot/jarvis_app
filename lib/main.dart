import 'package:flutter/material.dart';
import 'package:get/get.dart';

// This drawer widget was heavily based on: https://gist.github.com/eduardoflorence/9ef5035ac7e57eb2f15ceabcae430538 all due credit to this source
void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: Get.key,
    initialRoute: '/home',
    getPages: [
      GetPage(
        name: '/home',
        page: () => Home(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: '/environment',
        page: () => EnvironmentPage(),
        binding: EnvironmentPageBinding(),
      ),
      GetPage(
        name: '/motor',
        page: () => MotorPage(),
        binding: MotorPageBinding(),
      ),
    ],
  ));
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);
              Get.back();
              Get.offNamed('/home');
            },
          ),
          ListTile(
            title: Text('Environment'),
            tileColor:
                Get.currentRoute == '/environment' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/environment');
            },
          ),
          ListTile(
            title: Text('Motor'),
            tileColor: Get.currentRoute == '/motor' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/motor');
            },
          ),
        ],
      ),
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RocketPy Jarvis")),
      body: const Center(
        child: Text('Home'),
      ),
      drawer: MainDrawer(),
    );
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    print('>>> HomeController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> HomeController ready');
    super.onReady();
  }
}

class EnvironmentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnvironmentPageController());
  }
}

class EnvironmentPage extends GetView<EnvironmentPageController> {
  const EnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Environment')),
      drawer: MainDrawer(),
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}

class EnvironmentPageController extends GetxController {
  final title = 'Environment';

  @override
  void onInit() {
    print('>>> EnvPageController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> EnvPageController ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> EnvPageController close');
    super.onClose();
  }
}

class MotorPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MotorPageController());
  }
}

class MotorPage extends GetView<MotorPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motor')),
      drawer: MainDrawer(),
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}

class MotorPageController extends GetxController {
  final title = 'Motor';

  @override
  void onInit() {
    print('>>> MotorPageController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> MotorPageController ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> MotorPageController close');
    super.onClose();
  }
}
