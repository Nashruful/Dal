import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:components/components.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:impression/impression.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  Position? positionn;
  List<Marker> filteredMarkers = [];

  final dio = Dio();

  DiscoverBloc() : super(DiscoverInitial()) {
    on<ErrorScreenEvent>((event, emit) async {
      emit(ErrorState(msg: event.msg));
    });

    on<SendNotificationEvent>((event, emit) async {
      try {
        final Map storedTimes =
            getIt.get<DataLayer>().box.read('lastNotificationTimes') ?? {};
        getIt.get<DataLayer>().lastNotificationTimes = storedTimes
            .map((key, value) => MapEntry(key, DateTime.parse(value)));

        for (var location in getIt.get<DataLayer>().liveAds) {
          double distance = Geolocator.distanceBetween(
            event.position!.latitude,
            event.position!.longitude,
            location.branch!.latitude!,
            location.branch!.longitude!,
          );
          final currentCategory = location.category!.toString();

          if (distance <= 1000 &&
              getIt.get<DataLayer>().categories[currentCategory] == true) {
            String branchId = location.branch!.id!; // store branches ID
            DateTime now = DateTime.now();
            DateTime? lastNotificationTime =
                getIt.get<DataLayer>().lastNotificationTimes[branchId];

            if (lastNotificationTime == null ||
                now.difference(lastNotificationTime).inHours >= 12) {
              try {
                await dio.post(
                  "https://api.onesignal.com/api/v1/notifications",
                  data: {
                    "app_id": dotenv.env["ONE_SIGNAL_APP_ID"].toString(),
                    "contents": {
                      "en":
                          "Check out ${location.branch!.business!.name!} offer nearby! 📣",
                      "ar":
                          "لا يطوفك عرض ${location.branch!.business!.name!}! 📣"
                    },
                    "include_external_user_ids": [
                      getIt.get<DataLayer>().supabase.auth.currentUser!.id
                    ],
                    "data": {
                      "page": "/offer_details",
                      "offer_id": location.id!.toString(),
                    },
                  },
                  options: Options(headers: {
                    "Authorization": dotenv.env["AUTH_NOTIFICATION"].toString(),
                    'Content-Type': 'application/json',
                  }),
                );

                getIt.get<DataLayer>().lastNotificationTimes[branchId] =
                    now; // Update the last notification time
              } on DioException catch (e) {
                emit(ErrorState(msg: e.response!.data));
              } catch (_) {}
            }
          }
        }

        // Save the last notification times to GetStorage
        final Map serializedTimes = getIt
            .get<DataLayer>()
            .lastNotificationTimes
            .map((key, value) => MapEntry(key, value.toIso8601String()));

        getIt
            .get<DataLayer>()
            .box
            .write('lastNotificationTimes', serializedTimes);
      } catch (_) {}
    });
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      try {
        positionn = event.position;

        emit(SuccessState());
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    getIt.get<DataLayer>().locationBgStream();
    return super.close();
  }
}
