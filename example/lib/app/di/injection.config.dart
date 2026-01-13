// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:device_identifiers_example/views/device_id/cubit/device_id_cubit.dart'
    as _i621;
import 'package:device_identifiers_example/views/home/cubit/home_cubit.dart'
    as _i863;
import 'package:device_identifiers_example/views/imei/cubit/imei_cubit.dart'
    as _i58;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i621.DeviceIdCubit>(() => _i621.DeviceIdCubit());
    gh.factory<_i863.HomeCubit>(() => _i863.HomeCubit());
    gh.factory<_i58.ImeiCubit>(() => _i58.ImeiCubit());
    return this;
  }
}
