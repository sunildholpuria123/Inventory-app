import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/purchase_order_model.dart';
import 'purchase_forecast_provider.dart';

final purchaseOrderProvider =
FutureProvider<
    List<PurchaseOrderModel>>(
      (ref) {
    return ref
        .watch(
      analyticsRepositoryProvider,
    )
        .generatePurchaseOrders();
  },
);