import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget child;

  const AppPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width;

    final padding =
    width > 1200
        ? 32.0
        : width > 700
        ? 24.0
        : 16.0;

    return Padding(
      padding:
      EdgeInsets.all(padding),
      child: child,
    );
  }
}