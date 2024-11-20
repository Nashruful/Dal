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
  List<Marker> allMarkers = [];

  final dio = Dio();

  bool showButton = false;
  bool autoTrack = true;

  DiscoverBloc() : super(DiscoverInitial()) {
    on<ErrorScreenEvent>((event, emit) async {
      emit(ErrorState(msg: event.msg));
    });

    on<UpdateScreenTrackEvent>((event,emit)async{
      emit(SuccessState());
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
        allMarkers = getIt
            .get<DataLayer>()
            .liveAds
            .map((location) {
              double distance = Geolocator.distanceBetween(
                event.position!.latitude,
                event.position!.longitude,
                location.branch!.latitude!,
                location.branch!.longitude!,
              );

              if (distance <= 1000) {
                return Marker(
                  width: 50,
                  height: 50,
                  point: LatLng(
                      location.branch!.latitude!, location.branch!.longitude!),
                  child: ImpressionDetector(
                    impressedCallback: () {
                      getIt.get<DataLayer>().recordImpressions(location
                          .id!); //add impressions to ad id each time it is viewed
                    },
                    child: InkWell(
                      onTap: () {
                        getIt.get<DataLayer>().recordClicks(location
                            .id!); //add impressions to ad id each time it is clicked
                        String categoryIcon = location.category!.toString();
                        showDialog(
                            context: event.context,
                            builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: BottomSheetForMap(
                                      locationOnPressed: () async {
                                        final availableMaps =
                                            await MapLauncher.installedMaps;

                                        if (availableMaps.isNotEmpty) {
                                          await availableMaps.first.showMarker(
                                            coords: Coords(
                                                location.branch!.latitude!,
                                                location.branch!.longitude!),
                                            title: location
                                                .branch!.business!.name!,
                                          );
                                        } else {
                                          // Handle the case where no maps are installed

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'No maps are installed on this device.'
                                                        .tr())),
                                          );
                                        }
                                      },
                                      image: location.bannerimg!,
                                      companyName:
                                          location.branch!.business!.name!,
                                      iconImage: "assets/svg/$categoryIcon.svg",
                                      description: location.description!,
                                      remainingDay: getIt
                                          .get<DataLayer>()
                                          .getRemainingTime(location.enddate!),
                                      offerType: location.offerType!,
                                      viewLocation: "View Location".tr()),
                                ));
                      },
                      child: Badge(
                        label: Text(
                          "${location.offerType}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: AvatarGlow(
                            glowColor: Colors.redAccent,
                            repeat: true,
                            glowShape: BoxShape.circle,
                            glowRadiusFactor: 0.7,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors().white1,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 3, color: AppColors().white1)),
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  fit: BoxFit.fill,
                                  location.branch!.business!.logoImg!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (distance > 1000) {
                return Marker(
                  width: 50,
                  height: 50,
                  point: LatLng(
                      location.branch!.latitude!, location.branch!.longitude!),
                  child: ImpressionDetector(
                    impressedCallback: () {
                      getIt.get<DataLayer>().recordImpressions(location
                          .id!); //add impressions to ad id each time it is viewed
                    },
                    child: InkWell(
                      onTap: () {
                        getIt.get<DataLayer>().recordClicks(location
                            .id!); //add impressions to ad id each time it is clicked
                        String categoryIcon = location.category!.toString();
                        showDialog(
                            context: event.context,
                            builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: BottomSheetForMap(
                                      locationOnPressed: () async {
                                        final availableMaps =
                                            await MapLauncher.installedMaps;

                                        if (availableMaps.isNotEmpty) {
                                          await availableMaps.first.showMarker(
                                            coords: Coords(
                                                location.branch!.latitude!,
                                                location.branch!.longitude!),
                                            title: location
                                                .branch!.business!.name!,
                                          );
                                        } else {
                                          // Handle the case where no maps are installed

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'No maps are installed on this device.'
                                                        .tr())),
                                          );
                                        }
                                      },
                                      image: location.bannerimg!,
                                      companyName:
                                          location.branch!.business!.name!,
                                      iconImage: "assets/svg/$categoryIcon.svg",
                                      description: location.description!,
                                      remainingDay: getIt
                                          .get<DataLayer>()
                                          .getRemainingTime(location.enddate!),
                                      offerType: location.offerType!,
                                      viewLocation: "View Location".tr()),
                                ));
                      },
                      child: Badge(
                        label: Text(
                          "${location.offerType}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors().white1,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 3, color: AppColors().white1)),
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                fit: BoxFit.fill,
                                location.branch!.business!.logoImg!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            })
            .whereType<Marker>()
            .toList();

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
