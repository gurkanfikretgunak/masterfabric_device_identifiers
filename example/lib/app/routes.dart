import 'package:go_router/go_router.dart';
import 'package:masterfabric_device_identifiers_example/views/home/home_view.dart';
import 'package:masterfabric_device_identifiers_example/views/device_id/device_id_view.dart';
import 'package:masterfabric_device_identifiers_example/views/imei/imei_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String deviceId = '/device-id';
  static const String imei = '/imei';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: home,
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => HomeView(
            goRoute: (path) => context.push(path),
          ),
        ),
        GoRoute(
          path: deviceId,
          builder: (context, state) => DeviceIdView(
            goRoute: (path) => context.push(path),
          ),
        ),
        GoRoute(
          path: imei,
          builder: (context, state) => ImeiView(
            goRoute: (path) => context.push(path),
          ),
        ),
      ],
    );
  }
}
