class DatabaseStatistics {
  final int customers;
  final int suppliers;
  final int products;
  final int invoices;
  final int invoiceItems;
  final int payments;
  final int expenses;
  final int category;
  final int businessSetting;

  const DatabaseStatistics({
    required this.customers,
    required this.suppliers,
    required this.products,
    required this.invoices,
    required this.invoiceItems,
    required this.payments,
    required this.expenses,
    required this.category,
    required this.businessSetting
  });

  int get total =>
      customers +
          suppliers +
          products +
          invoices +
          invoiceItems +
          payments +
          expenses+category+businessSetting;
}