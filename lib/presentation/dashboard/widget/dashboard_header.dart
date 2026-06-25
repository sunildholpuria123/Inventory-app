import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../settings/provider/settings_provider.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final settings =
    ref.watch(
      businessSettingsProvider,
    );

    final now = DateTime.now();

    final date =
    DateFormat(
      'EEEE, dd MMM yyyy',
    ).format(now);

    String greeting = 'Good Evening';

    if (now.hour < 12) {
      greeting = 'Good Morning';
    } else if (now.hour < 17) {
      greeting = 'Good Afternoon';
    }

    return settings.when(
      data: (business) {
        final name =
        business?.companyName
            .trim()
            .isNotEmpty ==
            true
            ? business!.companyName
            : 'Inventory ERP';

        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting 👋',
                    style:
                    Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    name,
                    style:
                    Theme.of(context)
                        .textTheme
                        .titleMedium,
                  ),

                  const SizedBox(
                    height: 4,
                  ),

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

            const SizedBox(
              width: 12,
            ),

            CircleAvatar(
              radius: 22,
              child: Text(
                name.isNotEmpty
                    ? name[0]
                    .toUpperCase()
                    : 'I',
              ),
            ),
          ],
        );
      },

      loading:
          () => const SizedBox(
        height: 60,
      ),

      error:
          (_, __) => Row(
        children: [
          Expanded(
            child: Text(
              date,
            ),
          ),
        ],
      ),
    );
  }
}