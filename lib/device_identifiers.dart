export 'src/device_identifiers_platform_interface.dart';
export 'src/device_identifiers_method_channel.dart';

import 'package:flutter/services.dart';
import 'src/device_identifiers_platform_interface.dart';

/// A Flutter plugin that provides unique device identifiers for Android and iOS.
class DeviceIdentifiers {
  /// Returns a unique identifier for the device.
  /// 
  /// On Android: Returns Settings.Secure.ANDROID_ID
  /// On iOS: Returns UIDevice.identifierForVendor
  /// 
  /// Returns null if the identifier cannot be retrieved.
  static Future<String?> getDeviceIdentifier() {
    return DeviceIdentifiersPlatform.instance.getDeviceIdentifier();
  }

  /// Returns the IMEI (International Mobile Equipment Identity) of the device.
  /// 
  /// **Android Only** - Returns null on iOS and other platforms.
  /// 
  /// On Android: Returns the device IMEI number from TelephonyManager.
  /// - For Android 8.0+ (API 26+): Uses TelephonyManager.getImei()
  /// - For Android < 8.0: Uses TelephonyManager.getDeviceId()
  /// 
  /// **Important Requirements:**
  /// - Requires READ_PHONE_STATE permission
  /// - User must grant this permission at runtime (for Android 6.0+)
  /// - May return null if device doesn't have telephony (tablets)
  /// 
  /// **Throws:**
  /// - [PlatformException] with code 'PERMISSION_DENIED' if permission not granted
  /// 
  /// **Returns:** 
  /// - IMEI string (15 digits) on success
  /// - null if IMEI cannot be retrieved or not available
  /// 
  /// **Example:**
  /// ```dart
  /// try {
  ///   final imei = await DeviceIdentifiers.getImei();
  ///   print('IMEI: $imei');
  /// } on PlatformException catch (e) {
  ///   if (e.code == 'PERMISSION_DENIED') {
  ///     print('Permission denied: ${e.message}');
  ///   }
  /// }
  /// ```
  static Future<String?> getImei() {
    return DeviceIdentifiersPlatform.instance.getImei();
  }
}
