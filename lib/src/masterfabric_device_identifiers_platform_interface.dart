import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'masterfabric_device_identifiers_method_channel.dart';

abstract class DeviceIdentifiersPlatform extends PlatformInterface {
  DeviceIdentifiersPlatform() : super(token: _token);

  static final Object _token = Object();
  static DeviceIdentifiersPlatform _instance = MethodChannelDeviceIdentifiers();

  static DeviceIdentifiersPlatform get instance => _instance;

  static set instance(DeviceIdentifiersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDeviceIdentifier() {
    throw UnimplementedError('getDeviceIdentifier() has not been implemented.');
  }

  Future<String?> getImei() {
    throw UnimplementedError('getImei() has not been implemented.');
  }
}
