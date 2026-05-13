import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item.dart';

/// CURRENT CART ITEMS
final invoiceItemsProvider =
StateProvider<List<CartItem>>(
      (ref) => [],
);

/// SELECTED CUSTOMER
final selectedCustomerProvider =
StateProvider<dynamic?>(
      (ref) => null,
);

/// TAX %
final taxPercentProvider =
StateProvider<double>(
      (ref) => 0,
);

/// DISCOUNT
final discountProvider =
StateProvider<double>(
      (ref) => 0,
);

/// PAYMENT METHOD
final paymentMethodProvider =
StateProvider<String>(
      (ref) => 'CASH',
);

/// SUBTOTAL
final subtotalProvider =
Provider<double>((ref) {
  final items = ref.watch(
    invoiceItemsProvider,
  );

  return items.fold(
    0,
        (sum, item) =>
    sum + item.total,
  );
});

/// TAX
final taxProvider =
Provider<double>((ref) {
  final subtotal = ref.watch(
    subtotalProvider,
  );

  final taxPercent = ref.watch(
    taxPercentProvider,
  );

  return subtotal *
      (taxPercent / 100);
});

/// GRAND TOTAL
final grandTotalProvider =
Provider<double>((ref) {
  final subtotal = ref.watch(
    subtotalProvider,
  );

  final tax = ref.watch(
    taxProvider,
  );

  final discount = ref.watch(
    discountProvider,
  );

  return subtotal +
      tax -
      discount;
});