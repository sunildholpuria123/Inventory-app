import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/provider/theme_provider.dart';
import 'core/services/notification_service.dart';

import 'presentation/auth/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1400, 900),
    minimumSize: Size(1200, 700),
    center: true,
    title: 'Inventory ERP',
  );

  windowManager.waitUntilReadyToShow(
    windowOptions,
        () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  runApp(
    const ProviderScope(
      child: InventoryApp(),
    ),
  );
}

class InventoryApp extends ConsumerWidget {
  const InventoryApp({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final themeMode = ref.watch(
      themeModeProvider,
    );

    return MaterialApp(
      debugShowCheckedModeBanner:
      false,

      themeMode: themeMode,

      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed:
        Colors.indigo,
      ),

      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
  }
}