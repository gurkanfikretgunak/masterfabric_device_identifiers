import 'package:equatable/equatable.dart';

class DeviceIdState extends Equatable {
  final String? deviceId;
  final bool isLoading;
  final String? errorMessage;

  const DeviceIdState({
    this.deviceId,
    this.isLoading = false,
    this.errorMessage,
  });

  DeviceIdState copyWith({
    String? deviceId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DeviceIdState(
      deviceId: deviceId ?? this.deviceId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [deviceId, isLoading, errorMessage];
}
