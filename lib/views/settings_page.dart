import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Obx(() => ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeController.isDarkMode,
                  onChanged: (value) => themeController.toggleTheme(),
                ),
              )),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('App Version'),
            trailing: const Text('1.0.0'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              // Add logout functionality here
              Get.snackbar(
                'Logout',
                'Logout functionality to be implemented',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
    );
  }
}
