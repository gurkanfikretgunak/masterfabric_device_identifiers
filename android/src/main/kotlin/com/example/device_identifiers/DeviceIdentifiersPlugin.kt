package com.example.device_identifiers

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.telephony.TelephonyManager
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class DeviceIdentifiersPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_identifiers")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getDeviceIdentifier" -> {
        try {
          val androidId = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
          result.success(androidId)
        } catch (e: Exception) {
          result.error("ERROR", "Failed to get device identifier", e.message)
        }
      }
      "getImei" -> {
        try {
          val imei = getImei()
          result.success(imei)
        } catch (e: SecurityException) {
          result.error("PERMISSION_DENIED", "READ_PHONE_STATE permission is required", e.message)
        } catch (e: Exception) {
          result.error("ERROR", "Failed to get IMEI", e.message)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun getImei(): String? {
    // Check if permission is granted
    if (ContextCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) 
        != PackageManager.PERMISSION_GRANTED) {
      throw SecurityException("READ_PHONE_STATE permission not granted")
    }

    val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as? TelephonyManager
      ?: return null

    return try {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        // Android 8.0 (API 26) and above
        telephonyManager.imei
      } else {
        @Suppress("DEPRECATION")
        telephonyManager.deviceId
      }
    } catch (e: SecurityException) {
      throw e
    } catch (e: Exception) {
      null
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
