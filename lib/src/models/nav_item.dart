import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;
  final Widget screen;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showBadge;

  const NavItem({
    required this.label,
    required this.icon,
    required this.screen,
    this.activeColor,
    this.inactiveColor,
    this.showBadge = false,
  });
}
