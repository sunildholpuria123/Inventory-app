import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers/database_provider.dart';
import '../repository/analytics_repository.dart';

final analyticsRepositoryProvider =
Provider(
      (ref) {
    return AnalyticsRepository(
      ref.watch(
        databaseProvider,
      ),
    );
  },
);

final purchaseForecastProvider =
FutureProvider(
      (ref) {
    return ref
        .watch(
      analyticsRepositoryProvider,
    )
        .getPurchaseForecast();
  },
);