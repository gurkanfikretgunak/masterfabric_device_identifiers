import 'package:flutter/material.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'package:device_identifiers_example/app/app.dart';
import 'package:device_identifiers_example/app/routes.dart' as app_routes;
import 'package:device_identifiers_example/app/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize MasterApp components
  await MasterApp.runBefore(
    assetConfigPath: 'assets/app_config.json',
    hydrated: false,
  );
  
  // Configure dependency injection
  di.configureDependencies();
  
  // Create router
  final router = app_routes.AppRoutes.createRouter();
  
  runApp(App(router: router));
}
