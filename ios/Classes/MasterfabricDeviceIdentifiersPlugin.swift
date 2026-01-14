import Flutter
import UIKit

public class MasterfabricDeviceIdentifiersPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "masterfabric_device_identifiers", binaryMessenger: registrar.messenger())
    let instance = MasterfabricDeviceIdentifiersPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getDeviceIdentifier" {
      if let identifier = UIDevice.current.identifierForVendor?.uuidString {
        result(identifier)
      } else {
        result(FlutterError(code: "ERROR", message: "Failed to get device identifier", details: nil))
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
