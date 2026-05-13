import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/auto_backup_service.dart' show AutoBackupService;
import '../../dashboard/screen/dashboard_screen.dart';
import '../provider/auth_provider.dart';

class LoginScreen
    extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState<LoginScreen>
  createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends ConsumerState<LoginScreen> {
  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,

          child: Card(
            child: Padding(
              padding:
              const EdgeInsets.all(
                30,
              ),

              child: Column(
                mainAxisSize:
                MainAxisSize.min,

                children: [
                  const Icon(
                    Icons.inventory,
                    size: 80,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Inventory ERP',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller:
                    emailController,

                    decoration:
                    const InputDecoration(
                      labelText:
                      'Email',
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller:
                    passwordController,

                    obscureText: true,

                    decoration:
                    const InputDecoration(
                      labelText:
                      'Password',
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width:
                    double.infinity,

                    height: 50,

                    child: ElevatedButton(
                      onPressed:
                      isLoading
                          ? null
                          : () async {
                        setState(() {
                          isLoading =
                          true;
                        });

                        final repo =
                        ref.read(
                          authRepositoryProvider,
                        );

                        final user =
                        await repo.login(
                          email:
                          emailController.text,
                          password:
                          passwordController.text,
                        );

                        setState(() {
                          isLoading =
                          false;
                        });

                        if (user ==
                            null) {
                          if (context
                              .mounted) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  'Invalid Credentials',
                                ),
                              ),
                            );
                          }

                          return;
                        }

                        ref
                            .read(
                          authUserProvider
                              .notifier,
                        )
                            .state = user;

                        if (context
                            .mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                              const DashboardScreen(),
                            ),
                          );
                          await AutoBackupService
                              .autoBackup();
                        }
                      },

                      child:
                      isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                        'Login',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}