import 'package:bloc/bloc.dart';
import 'package:components/component/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/models/all_ads_model.dart';
import 'package:user_app/setup/setup.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  Position? position;

  HomeCubit() : super(HomeInitial());

  ElevatedButton returnButton(Ads e) {
    if (!getIt.get<DataLayer>().myReminders.contains(e)) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors().green),
          onPressed: () {
            getIt.get<DataLayer>().myReminders.add(e);
            emit(SuccessState());
          },
          child: Row(
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: AppColors().white1,
              ),
              Text('Remind me',
                  style: TextStyle(
                    color: AppColors().white1,
                  )),
            ],
          ));
    } else {
      return ElevatedButton(
          onPressed: () {
            getIt.get<DataLayer>().myReminders.remove(e);
            emit(SuccessState());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffA51361)),
          child: Row(
            children: [
              Icon(
                Icons.notifications_off_outlined,
                color: AppColors().white1,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('Remove reminder',
                  style: TextStyle(
                    color: AppColors().white1,
                  )),
            ],
          ));
    }
  }

  refreshPage() async {
    emit(LoadingState());
    getIt.get<DataLayer>().liveAds.clear();
    getIt.get<DataLayer>().allAds.clear();
    getIt.get<DataLayer>().nearbyBranches.clear();
    getIt.get<DataLayer>().diningCategory.clear();
    getIt.get<DataLayer>().fashionCategory.clear();
    getIt.get<DataLayer>().superMarketsCategory.clear();
    getIt.get<DataLayer>().hotelsCategory.clear();
    getIt.get<DataLayer>().gymCategory.clear();
    try {
      position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      await getIt.get<DataLayer>().getAllAds();
      for (var element in getIt.get<DataLayer>().allAds) {
        // get nearby branches to the user
        double distance = Geolocator.distanceBetween(
            position!.latitude,
            position!.longitude,
            element.branch!.latitude!,
            element.branch!.longitude!);
        if (distance < 1000) {
          getIt.get<DataLayer>().nearbyBranches.add(element);
        }
      }

      for (var element in getIt.get<DataLayer>().liveAds) {
        switch (element.category) {
          case "Dining":
            getIt.get<DataLayer>().diningCategory.add(element);

            break;
          case "Supermarkets":
            getIt.get<DataLayer>().superMarketsCategory.add(element);
            break;
          case "Fashion":
            getIt.get<DataLayer>().fashionCategory.add(element);
            break;
          case "Hotels":
            getIt.get<DataLayer>().hotelsCategory.add(element);
            break;
          case "Gym":
            getIt.get<DataLayer>().gymCategory.add(element);
            break;

          default:
            break;
        }
      }

      emit(SuccessState());
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    }
  }

  getAllAds() async {
    if (getIt.get<DataLayer>().liveAds.isEmpty) {
      emit(LoadingState());
      try {
        position = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings);

        await getIt.get<DataLayer>().getAllAds();
        for (var element in getIt.get<DataLayer>().liveAds) {
          // get nearby branches to the user
          double distance = Geolocator.distanceBetween(
              position!.latitude,
              position!.longitude,
              element.branch!.latitude!,
              element.branch!.longitude!);
          if (distance < 1000) {
            getIt.get<DataLayer>().nearbyBranches.add(element);
          }
        }

        for (var element in getIt.get<DataLayer>().liveAds) {
          switch (element.category) {
            case "Dining":
              getIt.get<DataLayer>().diningCategory.add(element);

              break;
            case "Supermarkets":
              getIt.get<DataLayer>().superMarketsCategory.add(element);
              break;
            case "Fashion":
              getIt.get<DataLayer>().fashionCategory.add(element);
              break;
            case "Hotels":
              getIt.get<DataLayer>().hotelsCategory.add(element);
              break;
            case "Gym":
              getIt.get<DataLayer>().gymCategory.add(element);
              break;

            default:
              break;
          }
        }

        emit(SuccessState());
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
      }
    } else {
      emit(SuccessState());
    }
  }
}
