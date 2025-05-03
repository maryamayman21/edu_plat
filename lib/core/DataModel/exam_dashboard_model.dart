import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final Color backGroundColor;
  final String routeName;

  DashboardItem(  {
    required this.backGroundColor,
    required this.title,
    required this.icon,
    required this.color,
    required this.routeName,
  });
}
