import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  final String title;

  const AppTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
            Theme.of(context)
                .textTheme
                .headlineSmall,
          ),
        ),

        IconButton(
          onPressed: () {},
          icon:
          const Icon(
            Icons.search,
          ),
        ),

        IconButton(
          onPressed: () {},
          icon:
          const Icon(
            Icons.notifications_none,
          ),
        ),

        const SizedBox(width: 12),

        const CircleAvatar(
          radius: 20,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}