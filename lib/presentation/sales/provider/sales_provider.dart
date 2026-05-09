import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/database_provider.dart';
import '../../../data/repositories/sales_repository.dart';
import '../model/invoice_item.dart';
final invoiceItemsProvider =
StateProvider<List<InvoiceItem>>(
      (ref) => [],
);

final selectedCustomerProvider =
StateProvider<Customer?>(
      (ref) => null,
);

final discountProvider =
StateProvider<double>(
      (ref) => 0,
);

final taxProvider =
StateProvider<double>(
      (ref) => 0,
);

final subtotalProvider =
Provider<double>((ref) {
  final items =
  ref.watch(invoiceItemsProvider);

  return items.fold(
    0,
        (sum, item) => sum + item.subtotal,
  );
});

final grandTotalProvider =
Provider<double>((ref) {
  final subtotal =
  ref.watch(subtotalProvider);

  final discount =
  ref.watch(discountProvider);

  final tax = ref.watch(taxProvider);

  return subtotal + tax - discount;
});

final salesRepositoryProvider =
Provider<SalesRepository>((ref) {
  final db = ref.watch(
    databaseProvider,
  );

  return SalesRepository(db);
});