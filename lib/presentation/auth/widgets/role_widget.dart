import 'package:flutter/material.dart';

class RoleWidget
    extends StatelessWidget {
  final String role;

  final Widget child;

  const RoleWidget({
    super.key,
    required this.role,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const currentRole = 'ADMIN';

    if (currentRole == role) {
      return child;
    }

    return const SizedBox.shrink();
  }
}