import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/provider/theme_provider.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final brightness =
        Theme.of(context).brightness;

    final date =
    DateFormat(
      'EEEE, dd MMM yyyy',
    ).format(
      DateTime.now(),
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Sunil 👋',
                style:
                Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                date,
                style:
                Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ],
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

        IconButton(
          onPressed: () {
            final notifier =
            ref.read(
              themeModeProvider
                  .notifier,
            );

            notifier.state =
            brightness ==
                Brightness.dark
                ? ThemeMode.light
                : ThemeMode.dark;
          },
          icon: Icon(
            brightness ==
                Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        ),

        const SizedBox(width: 12),

        const CircleAvatar(
          radius: 22,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}