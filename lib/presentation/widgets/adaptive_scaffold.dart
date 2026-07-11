import 'package:flutter/material.dart';

import '../../core/utils/responsive_helper.dart';
import '../../core/widgets/app_sidebar.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;

  final String title;

  const AdaptiveScaffold({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    final isTablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      appBar: isMobile ? AppBar(title: Text(title)) : null,

      drawer: isMobile ? const Drawer(child: AppSidebar()) : null,

      body: Row(
        children: [
          if (!isMobile)
            SizedBox(width: isTablet ? 90 : 260, child: const AppSidebar()),

          Expanded(child: body),
        ],
      ),
    );
  }
}
