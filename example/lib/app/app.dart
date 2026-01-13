import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import '../theme/app_theme.dart';

class App extends StatelessWidget {
  final GoRouter router;

  const App({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: MasterApp(
        router: router,
        shouldSetOrientation: true,
        showPerformanceOverlay: false,
        textDirection: TextDirection.ltr,
        fontScale: 1.0,
      ),
    );
  }
}
