import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';

class NotificationsPage extends StatelessWidget {
  final NavigationController controller = Get.find();

  NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              controller.clearBadge(1);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Notifications Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Obx(() {
              final badgeCount = controller.getBadgeCount(1);
              return Text(
                'You have $badgeCount unread notifications',
                style: const TextStyle(fontSize: 16),
              );
            }),
          ],
        ),
      ),
    );
  }
}
