import 'package:flutter/material.dart';

class ProductStockBadge extends StatelessWidget {
  final double qty;
  final double minStock;

  const ProductStockBadge({
    super.key,
    required this.qty,
    required this.minStock,
  });

  @override
  Widget build(BuildContext context) {
    final low = qty <= minStock;

    return Chip(
      label: Text(low ? 'Low Stock' : 'In Stock'),
      backgroundColor: low ? Colors.red.shade100 : Colors.green.shade100,
    );
  }
}
