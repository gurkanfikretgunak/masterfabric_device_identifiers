import 'package:flutter/services.dart';
import 'masterfabric_device_identifiers_platform_interface.dart';

class MethodChannelDeviceIdentifiers extends DeviceIdentifiersPlatform {
  static const MethodChannel _channel = MethodChannel('masterfabric_device_identifiers');

  @override
  Future<String?> getDeviceIdentifier() async {
    try {
      final String? identifier = await _channel.invokeMethod<String>('getDeviceIdentifier');
      return identifier;
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<String?> getImei() async {
    try {
      final String? imei = await _channel.invokeMethod<String>('getImei');
      return imei;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'READ_PHONE_STATE permission is required to get IMEI',
          details: e.details,
        );
      }
      return null;
    }
  }
}
