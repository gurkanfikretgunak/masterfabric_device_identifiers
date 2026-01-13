import 'package:flutter_test/flutter_test.dart';
import 'package:device_identifiers/device_identifiers.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceIdentifiersPlatform 
    with MockPlatformInterfaceMixin
    implements DeviceIdentifiersPlatform {

  @override
  Future<String?> getDeviceIdentifier() => Future.value('mock_device_id');

  @override
  Future<String?> getImei() => Future.value('123456789012345');
}

void main() {
  final DeviceIdentifiersPlatform initialPlatform = DeviceIdentifiersPlatform.instance;

  test('$MethodChannelDeviceIdentifiers is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceIdentifiers>());
  });

  test('getDeviceIdentifier', () async {
    MockDeviceIdentifiersPlatform fakePlatform = MockDeviceIdentifiersPlatform();
    DeviceIdentifiersPlatform.instance = fakePlatform;

    expect(await DeviceIdentifiers.getDeviceIdentifier(), 'mock_device_id');
  });

  test('getImei', () async {
    MockDeviceIdentifiersPlatform fakePlatform = MockDeviceIdentifiersPlatform();
    DeviceIdentifiersPlatform.instance = fakePlatform;

    expect(await DeviceIdentifiers.getImei(), '123456789012345');
  });
}

