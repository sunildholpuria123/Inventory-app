import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_desktop/core/provider/database_provider.dart';
import 'package:inventory_desktop/data/providers/database_provider.dart';

import '../../expenses/provider/expense_provider.dart';
import '../../purchases/provider/purchase_repository_provider.dart';
import '../../sales/provider/sales_repository_provider.dart';
import '../model/transaction_timeline_item.dart';

final transactionTimelineProvider =
    FutureProvider<List<TransactionTimelineItem>>((ref) async {
      final items = <TransactionTimelineItem>[];

      final salesRepo = ref.read(salesRepositoryProvider);

      final purchaseRepo = ref.read(purchaseRepositoryProvider);

      final expenseRepo = ref.read(expenseRepositoryProvider);

      ///
      /// SALES
      ///
      final invoices = await salesRepo.getAllInvoices();

      for (final invoice in invoices) {
        items.add(
          TransactionTimelineItem(
            title: 'Sale ${invoice.invoiceNo}',
            amount: invoice.grandTotal,
            date: invoice.createdAt,
            type: TransactionType.sale,
          ),
        );
      }

      ///
      /// PURCHASES
      ///
      final purchases = await purchaseRepo.getPurchases();

      for (final purchase in purchases) {
        items.add(
          TransactionTimelineItem(
            title: 'Purchase ${purchase.id}',
            amount: purchase.total,
            date: purchase.createdAt,
            type: TransactionType.purchase,
          ),
        );
      }

      ///
      /// EXPENSES
      ///
      final expenses = await expenseRepo.getAllExpenses();

      for (final expense in expenses) {
        items.add(
          TransactionTimelineItem(
            title: expense.title,
            amount: expense.amount,
            date: expense.createdAt,
            type: TransactionType.expense,
          ),
        );
      }

      ///
      /// CUSTOMER PAYMENTS
      ///
      for (final invoice in invoices) {
        if (invoice.amountPaid > 0) {
          items.add(
            TransactionTimelineItem(
              title: 'Customer Payment ${invoice.invoiceNo}',
              amount: invoice.amountPaid,
              date: invoice.createdAt,
              type: TransactionType.customerPayment,
            ),
          );
        }
      }

      ///
      /// SUPPLIER PAYMENTS
      ///

      items.sort((a, b) => b.date.compareTo(a.date));

      return items;
    });
