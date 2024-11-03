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

  int getTotalAds() {
    final totalAds = getIt.get<DataLayer>().allbusinessAds.length;
    return totalAds;
  }

  int getTotalViews(List adList) {
    int totalViews = 0;
    for (final ad in adList) {
      if (ad['views'] != null) {
        totalViews += ad['views'] as int;
      }
    }
    return totalViews;
  }

  int getTotalClicks(List adList) {
    int totalClicks = 0;
    for (final ad in adList) {
      if (ad['clicks'] != null) {
        totalClicks += ad['clicks'] as int;
      }
    }
    return totalClicks;
  }

  List<Map> getTopBranches() {
    final branches = getIt.get<DataLayer>().businessBranches;
    Map<String, int> branchTotalClicks = {};
    List<Map<String, dynamic>> result = [];
    for (final branch in branches) {
      int totalClicks = 0;

      for (final ad in branch['ad']) {
        final int clicks = ad['clicks'];

        totalClicks += clicks;
      }

      branchTotalClicks[branch['id']] = totalClicks;
    }

    // Sort the branches
    final sortedBranches = branchTotalClicks.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Get the top 5 branches as a list
    for (int i = 0;
        i < (sortedBranches.length < 5 ? sortedBranches.length : 5);
        i++) {
      final branchId = sortedBranches[i].key;
      final branch = branches.firstWhere((b) => b['id'] == branchId);
      result.add({
        'id': branchId,
        'address': branch['address'],
        'totalClicks': sortedBranches[i].value,
      });
    }

    return result;
  }

  Map<int, double> getViewsByMonth(List allads) {
    final Map<int, double> viewsByMonth = {
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
    for (final ad in allads) {
      int month = DateTime.parse(ad['startdate']).month;
      int views = ad['views'] as int;
      viewsByMonth[month] = (viewsByMonth[month] ?? 0) + views;
    }
    return viewsByMonth;
  }
}
