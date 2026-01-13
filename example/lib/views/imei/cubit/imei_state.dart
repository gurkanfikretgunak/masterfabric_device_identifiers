import 'package:equatable/equatable.dart';

class ImeiState extends Equatable {
  final String? imei;
  final bool isLoading;
  final String? errorMessage;
  final bool permissionDenied;

  const ImeiState({
    this.imei,
    this.isLoading = false,
    this.errorMessage,
    this.permissionDenied = false,
  });

  ImeiState copyWith({
    String? imei,
    bool? isLoading,
    String? errorMessage,
    bool? permissionDenied,
  }) {
    return ImeiState(
      imei: imei ?? this.imei,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      permissionDenied: permissionDenied ?? this.permissionDenied,
    );
  }

  @override
  List<Object?> get props => [imei, isLoading, errorMessage, permissionDenied];
}
