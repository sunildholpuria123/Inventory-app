import 'package:flutter/material.dart';

class CustomerTimelineItem {
  final String title;
  final String subtitle;
  final DateTime date;
  final IconData icon;
  final int? customerId;

  CustomerTimelineItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.customerId,
  });
}