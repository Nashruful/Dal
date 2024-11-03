import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:meta/meta.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  List allads = getIt.get<DataLayer>().allbusinessAds;

  StatisticsCubit() : super(StatisticsInitial());

  Future<void> refreshScreen() async {
    await getIt.get<DataLayer>().getBusinessInfo();
    allads = getIt.get<DataLayer>().allbusinessAds;

    emit(Loaded());
  }
}
