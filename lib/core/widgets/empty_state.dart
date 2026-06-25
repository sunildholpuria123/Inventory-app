import 'package:flutter/material.dart';

class EmptyState
    extends StatelessWidget {
  final String title;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Center(
      child: Column(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 80,
            color:
            Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(title),
        ],
      ),
    );
  }
}