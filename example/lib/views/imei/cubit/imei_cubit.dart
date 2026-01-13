import 'package:injectable/injectable.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'package:device_identifiers/device_identifiers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'imei_state.dart';

@injectable
class ImeiCubit extends BaseViewModelCubit<ImeiState> {
  ImeiCubit() : super(const ImeiState());

  Future<void> loadImei() async {
    if (!Platform.isAndroid) {
      stateChanger(state.copyWith(
        errorMessage: 'IMEI is only available on Android devices',
        isLoading: false,
      ));
      return;
    }

    stateChanger(state.copyWith(isLoading: true, errorMessage: null, permissionDenied: false));

    try {
      final status = await Permission.phone.status;
      if (!status.isGranted) {
        stateChanger(state.copyWith(
          isLoading: false,
          permissionDenied: true,
          errorMessage: 'Phone permission required',
        ));
        return;
      }

      final imei = await DeviceIdentifiers.getImei();
      stateChanger(state.copyWith(imei: imei, isLoading: false));
    } catch (e) {
      stateChanger(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
        permissionDenied: e.toString().contains('PERMISSION_DENIED'),
      ));
    }
  }

  Future<void> requestPermission() async {
    final status = await Permission.phone.request();
    if (status.isGranted) {
      await loadImei();
    } else {
      stateChanger(state.copyWith(
        permissionDenied: true,
        errorMessage: 'Permission denied by user',
      ));
    }
  }
}
