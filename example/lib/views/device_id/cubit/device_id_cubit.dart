import 'package:injectable/injectable.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'package:device_identifiers/device_identifiers.dart';
import 'device_id_state.dart';

@injectable
class DeviceIdCubit extends BaseViewModelCubit<DeviceIdState> {
  DeviceIdCubit() : super(const DeviceIdState());

  Future<void> loadDeviceId() async {
    stateChanger(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final deviceId = await DeviceIdentifiers.getDeviceIdentifier();
      stateChanger(state.copyWith(deviceId: deviceId, isLoading: false));
    } catch (e) {
      stateChanger(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }
}
