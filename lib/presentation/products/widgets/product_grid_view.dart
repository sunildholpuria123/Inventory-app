import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../data/database/app_database.dart';
import 'product_card_v2.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    int count = 1;

    if (!ResponsiveHelper.isMobile(context)) {
      final width = MediaQuery.of(context).size.width;

      if (width > 1800) {
        count = 5;
      } else if (width > 1400) {
        count = 4;
      } else {
        count = 3;
      }
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (_, index) {
        return ProductCardV2(product: products[index]);
      },
    );
  }
}
