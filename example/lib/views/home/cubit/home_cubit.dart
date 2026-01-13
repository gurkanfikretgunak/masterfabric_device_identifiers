import 'package:injectable/injectable.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'home_state.dart';

/// Home Cubit
@injectable
class HomeCubit extends BaseViewModelCubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadData() async {}
}
