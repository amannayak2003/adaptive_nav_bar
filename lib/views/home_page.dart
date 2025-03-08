import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';

class HomePage extends StatelessWidget {
  final NavigationController controller = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add a notification badge to the notifications tab
                controller.setBadgeCount(1, controller.getBadgeCount(1) + 1);
              },
              child: const Text('Add Notification Badge'),
            ),
          ],
        ),
      ),
    );
  }
}
