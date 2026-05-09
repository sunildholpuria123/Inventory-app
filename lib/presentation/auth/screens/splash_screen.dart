import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/screen/dashboard_screen.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class SplashScreen
    extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  ConsumerState<SplashScreen>
  createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {
    final repo = ref.read(
      authRepositoryProvider,
    );

    await repo.createDefaultAdmin();

    final loggedIn =
    await repo.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
        loggedIn
            ? const DashboardScreen()
            : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
        CircularProgressIndicator(),
      ),
    );
  }
}