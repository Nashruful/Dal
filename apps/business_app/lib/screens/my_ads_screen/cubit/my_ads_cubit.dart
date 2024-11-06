import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'my_ads_state.dart';
//
class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit() : super(MyAdsInitial());
  String planEndDate =
      getIt.get<DataLayer>().latestSubscription['end_date'] ?? '';
  DateTime currentDate = DateTime.now();

  //get current ads only
  List currentAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
    DateTime endDate = DateTime.parse(ad['enddate']);
    return endDate.isAfter(DateTime.now());
  }).toList();

  //get past ads only
  List pastAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
    DateTime endDate = DateTime.parse(ad['enddate']);
    return endDate.isBefore(DateTime.now());
  }).toList();

  deleteAd(String adId) async {
    emit(LoadingAdsState());

    await getIt.get<DataLayer>().supabase.from('ad').delete().eq('id', adId);
    await refreshInfo();
    emit(SuccessDeleteState());
  }

  refreshInfo() async {
    await getIt.get<DataLayer>().getBusinessInfo(); //refresh info list
    //get current ads only
    currentAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
      DateTime endDate = DateTime.parse(ad['enddate']);
      return endDate.isAfter(DateTime.now());
    }).toList();

    //get past ads only
    pastAds = getIt.get<DataLayer>().allbusinessAds.where((ad) {
      DateTime endDate = DateTime.parse(ad['enddate']);
      return endDate.isBefore(DateTime.now());
    }).toList();
    emit(SuccessRefreshState());
  }

  String getRemainingTime(String dateString) {
    //parse targettime
    DateTime targetDate = DateTime.parse(dateString);

// Calculate the difference
    Duration difference = targetDate.difference(DateTime.now());

// Get the remaining days
    int remainingDays = difference.inDays;
    if (remainingDays < 0) {
      remainingDays = 0;
    }
    return remainingDays.toString();
  }
}
