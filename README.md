# Adaptive Navigation Bar

A beautiful, animated, and customizable bottom navigation bar for Flutter with GetX state management.

## Features

- 🎨 Modern UI with glassmorphism effect
- ✨ Smooth animations and transitions
- 🌓 Dark/Light mode support
- 🔔 Badge notifications support
- 📱 Adaptive design
- 🎯 GetX state management
- 🎭 Customizable themes and colors

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  adaptive_nav_bar: ^1.0.0
  get: ^4.6.6  # Required for state management
```

## Usage

1. **Basic Setup**

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_package/adaptive_nav_bar.dart';

void main() {
  // Initialize controllers
  Get.put(NavigationController());
  runApp(MyApp());
}
```

2. **Create Navigation Items**

```dart
final List<NavItem> navigationItems = [
  NavItem(
    label: 'Home',
    icon: Icons.home_rounded,
    screen: HomePage(),
    activeColor: Colors.blue,
  ),
  NavItem(
    label: 'Notifications',
    icon: Icons.notifications_rounded,
    screen: NotificationsPage(),
    activeColor: Colors.orange,
    showBadge: true,  // Enable badge for this item
  ),
  // Add more items...
];
```

3. **Implement in Your App**

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,  // Important for transparent navigation bar
      body: Obx(() => IndexedStack(
        index: Get.find<NavigationController>().selectedIndex.value,
        children: navigationItems.map((item) => item.screen).toList(),
      )),
      bottomNavigationBar: AdaptiveNavBar(
        items: navigationItems,
        height: 65,
        elevation: 8,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        // Customize more properties...
      ),
    );
  }
}
```

4. **Badge Management**

```dart
// Add a badge notification
final controller = Get.find<NavigationController>();
controller.setBadgeCount(1, 5);  // Set badge count 5 for index 1

// Clear badge
controller.clearBadge(1);  // Clear badge for index 1

// Get badge count
int count = controller.getBadgeCount(1);
```

## Customization Options

```dart
AdaptiveNavBar(
  items: navigationItems,
  height: 65.0,                    // Height of the bar
  iconSize: 24.0,                  // Size of icons
  selectedFontSize: 14.0,          // Font size for selected item
  unselectedFontSize: 12.0,        // Font size for unselected items
  backgroundColor: Colors.white,    // Background color
  selectedItemColor: Colors.blue,   // Color for selected item
  unselectedItemColor: Colors.grey, // Color for unselected items
  showLabels: true,                // Show/hide all labels
  showSelectedLabels: true,        // Show/hide selected item label
  showUnselectedLabels: true,      // Show/hide unselected items label
  elevation: 8.0,                  // Elevation of the bar
  borderRadius: BorderRadius.circular(24), // Border radius
  animationDuration: Duration(milliseconds: 300), // Animation duration
  animationCurve: Curves.easeOutCubic,          // Animation curve
);
```

## Theme Support

The navigation bar automatically adapts to light/dark mode. You can customize the themes:

```dart
// Light theme
final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
);

// Dark theme
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFF1A1A1A),
);
```

## Advanced Usage

1. **Custom Animations**

```dart
AdaptiveNavBar(
  // ... other properties
  animationDuration: Duration(milliseconds: 400),
  animationCurve: Curves.easeOutBack,
);
```

2. **Glassmorphism Effect**

The navigation bar comes with a built-in glassmorphism effect that adapts to your theme.

3. **Badge Customization**

```dart
NavItem(
  label: 'Notifications',
  icon: Icons.notifications_rounded,
  screen: NotificationsPage(),
  activeColor: Colors.orange,
  showBadge: true,  // Enable badge
);

// Update badge count
controller.setBadgeCount(index, count);
```

## Best Practices

1. Always use `extendBody: true` in your Scaffold
2. Initialize the NavigationController before using the navigation bar
3. Use appropriate icon sizes (recommended: 24.0)
4. Keep the number of items between 2 and 5
5. Use meaningful icons and short labels
6. Consider accessibility when choosing colors

## Requirements

- Flutter: >=2.0.0
- Dart: >=2.12.0
- get: ^4.6.6

## License

This project is licensed under the MIT License - see the LICENSE file for details
