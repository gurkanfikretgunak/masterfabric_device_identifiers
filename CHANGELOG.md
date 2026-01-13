# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2026-01-13

### 🎉 Initial Release

#### Package Information
- **Package Name:** `masterfabric_device_identifiers`
- **Example Package:** `masterfabric_device_identifiers_example`
- **Organization:** MasterFabric (@masterfabric)
- **Author:** Gürkan Fikret Günak (@gurkanfikretgunak)

#### Added
- ✨ Core functionality to retrieve unique device identifiers
- 📱 Android support using `Settings.Secure.ANDROID_ID`
- 🍎 iOS support using `UIDevice.identifierForVendor`
- 🔢 **IMEI support for Android** with `DeviceIdentifiers.getImei()`
- 🔒 Runtime permission handling for IMEI (READ_PHONE_STATE)
- 🔌 Platform interface for extensibility
- 🧪 Unit tests with mock platform implementation
- 📖 Comprehensive documentation with examples
- 🛡️ Null-safe implementation
- ⚡ Lightweight with minimal dependencies
- 🎨 **Professional example app** using MasterFabric Core architecture
- 📄 MIT License with MasterFabric copyright

#### Features
- Simple API with two methods:
  - `DeviceIdentifiers.getDeviceIdentifier()` - Cross-platform device ID
  - `DeviceIdentifiers.getImei()` - Android IMEI (requires permission)
- Proper error handling with try-catch support
- Platform-specific implementations using method channels
- Returns `null` gracefully when identifier is unavailable
- Permission exception handling for IMEI access
- Example app demonstrating permission requests
- Full null-safety support
- Comprehensive inline documentation

#### Usage Example
```dart
import 'package:masterfabric_device_identifiers/masterfabric_device_identifiers.dart';

// Get Device ID
final deviceId = await DeviceIdentifiers.getDeviceIdentifier();
print('Device ID: $deviceId');

// Get IMEI (Android only)
try {
  final imei = await DeviceIdentifiers.getImei();
  print('IMEI: $imei');
} on PlatformException catch (e) {
  if (e.code == 'PERMISSION_DENIED') {
    print('Permission denied');
  }
}
```

#### Supported Platforms
- Android API 16+ (Android 4.1 Jelly Bean and above)
- iOS 11.0+

#### Technical Details
- Built with Flutter SDK >=1.17.0
- Dart SDK ^3.10.4
- Package name: `masterfabric_device_identifiers`
- Main library file: `masterfabric_device_identifiers.dart`
- Uses `plugin_platform_interface` ^2.0.0
- Uses `permission_handler` ^11.2.0
- Follows Flutter plugin best practices
- Android: Uses TelephonyManager for IMEI
- iOS: IMEI not available (platform restriction)

#### Library Structure
```
lib/
├── masterfabric_device_identifiers.dart (main export)
└── src/
    ├── masterfabric_device_identifiers_platform_interface.dart
    └── masterfabric_device_identifiers_method_channel.dart
```

#### Example App Architecture
- 🏗️ **MasterFabric Core** pattern implementation
- 💉 Dependency injection with Injectable + GetIt
- 🧭 GoRouter for declarative navigation
- 🎨 Material Design 3 custom theme
- 🔄 State management with BaseViewModelCubit
- 📱 Separate views for Device ID and IMEI
- 🔐 Complete permission request flow
- ⚡ Error handling and loading states
- 🎯 Professional UI with Lucide Icons

#### IMEI Implementation
- Android 8.0+ (API 26+): Uses `TelephonyManager.getImei()`
- Android < 8.0: Uses `TelephonyManager.getDeviceId()`
- Requires READ_PHONE_STATE permission
- Throws PlatformException when permission denied
- Returns null for tablets without cellular capability

---

## [Unreleased]

### Planned Features
- Additional device information methods
- macOS, Windows, and Linux support
- Web platform support (limited functionality)
- Enhanced error reporting
- Performance optimizations
- More device identifiers (Serial Number, MAC address, etc.)

### Example App Improvements
- Device ID and IMEI views currently in development
- Enhanced permission handling UI
- Copy to clipboard functionality
- Platform information display

---

**Author:** Gürkan Fikret Günak (@gurkanfikretgunak)  
**Organization:** MasterFabric (@masterfabric)  
**License:** MIT  

**Links:**
- [GitHub Repository](https://github.com/gurkanfikretgunak/device_identifiers)
- [MasterFabric Core](https://pub.dev/packages/masterfabric_core)

**Note:** This changelog will be updated with each new release.
