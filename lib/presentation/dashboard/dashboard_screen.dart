import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../products/provider/product_provider.dart';
import '../products/screens/product_list_screen.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context,      WidgetRef ref
      ) {
    final repo = ref.read(productRepositoryProvider);

     repo.addProduct(
      name: 'Cement',
      purchasePrice: 200,
      sellingPrice: 300,
      stockQty: 20,
    );
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const DashboardHeader(),

                  const SizedBox(height: 20),

                  const DashboardStats(),

                  const SizedBox(height: 20),

                  const Expanded(
                    child: ProductListScreen(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}