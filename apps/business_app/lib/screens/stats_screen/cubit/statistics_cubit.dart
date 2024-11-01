import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:meta/meta.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  List allads = getIt.get<DataLayer>().allbusinessAds;
  Map<int, double> viewsByMonth = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 12,
    10: 0,
    11: 0,
    12: 0,
  };
  StatisticsCubit() : super(StatisticsInitial());

  Future<void> refreshScreen() async {
    await getIt.get<DataLayer>().getBusinessInfo();
    allads = getIt.get<DataLayer>().allbusinessAds;

    //

    for (final ad in allads) {
      viewsByMonth = {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
        9: 0,
        10: 0,
        11: 0,
        12: 0,
      };
      int month = DateTime.parse(ad['startdate']).month;
      int views = ad['views'] as int;
      viewsByMonth[month] = (viewsByMonth[month] ?? 0) + views;
    }

    // viewsByMonth.forEach((month, views) {
    //   print('Month: $month, Views: $views');
    // });
    //

    emit(Loaded());
  }
}
