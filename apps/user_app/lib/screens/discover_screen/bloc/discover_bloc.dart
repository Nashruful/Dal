import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:meta/meta.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  bool buttonClicked = true;
  double areaDistance = 1000;
  Position? positionn;

  List<Marker> filteredMarkers = [];
  StreamSubscription<Position>? positionStream;

  DiscoverBloc() : super(DiscoverInitial()) {
    on<ErrorScreenEvent>((event, emit) async {
      emit(ErrorState(msg: event.msg));
    });
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      try {
        print(event.position!.latitude);
        positionn = event.position;
        areaDistance = buttonClicked ? 1000 : 500000;
        filteredMarkers = getIt
            .get<DataLayer>()
            .allAds
            .map((location) {
              double distance = Geolocator.distanceBetween(
                event.position!.latitude,
                event.position!.longitude,
                location.branch!.latitude!,
                location.branch!.longitude!,
              );

              return distance <= areaDistance
                  ? Marker(
                      width: 50,
                      height: 50,
                      point: LatLng(location.branch!.latitude!,
                          location.branch!.longitude!),
                      child: InkWell(
                        onTap: () {
                          String categoryIcon = location.category!.toString();
                          print(categoryIcon);
                          showDialog(
                              context: event.context,
                              builder: (context) => AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    content: BottomSheetForMap(
                                        locationOnPressed: () async {
                                          final availableMaps =
                                              await MapLauncher.installedMaps;
                                          print(
                                              availableMaps); // Output the available maps for debugging purposes

                                          if (availableMaps.isNotEmpty) {
                                            await availableMaps.first
                                                .showMarker(
                                              coords: Coords(
                                                  location.branch!.latitude!,
                                                  location.branch!.longitude!),
                                              title: location
                                                  .branch!.business!.name!,
                                            );
                                          } else {
                                            // Handle the case where no maps are installed
                                            print(
                                                "no maps installed on this device.");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'No maps are installed on this device.')),
                                            );
                                          }
                                        },
                                        image: location.bannerimg!,
                                        companyName:
                                            location.branch!.business!.name!,
                                        iconImage:
                                            "assets/svg/$categoryIcon.svg",
                                        description: location.description!,
                                        remainingDay: "function??",
                                        offerType: location.offerType!,
                                        viewLocation: "Open in map"),
                                  ));
                        },
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              colorBlendMode: BlendMode.clear,
                              location.branch!.business!.logoImg!,
                            ),
                          ),
                        ),
                      ))
                  : null;
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
    positionStream?.cancel();
    return super.close();
  }
}
