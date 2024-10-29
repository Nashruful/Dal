import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  late StreamSubscription<Position> positionStream;
  final LatLng initialCenter =
      const LatLng(24.82307363899628, 46.76960924937112);
  bool buttonClicked = false;
  double areaDistance = 1000;
  Position? position;

  // List of provided markers
  final List<LatLng> markerLocations = const [
    LatLng(24.81307299899741, 46.76503970781533),
    LatLng(24.82037851123455, 46.76296974609059),
    LatLng(24.81924369998163, 46.77445218221551),
    LatLng(24.835059154264727, 46.77699081816699),
    LatLng(24.83317984725718, 46.7532448270556),
  ];

  List<Marker> filteredMarkers = [];
  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) {});
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      areaDistance = buttonClicked ? 1000 : 500000;

      // Create markers from the provided locations and filter them
      filteredMarkers = markerLocations
          .map((location) {
            double distance = Geolocator.distanceBetween(
              position!.latitude,
              position!.longitude,
              location.latitude,
              location.longitude,
            );

            // Only include markers within 300 meters
            return distance <= areaDistance
                ? Marker(
                    width: 100,
                    height: 100,
                    point: location,
                    child: const Icon(
                        color: Colors.blueAccent,
                        size: 35,
                        Icons.location_on_rounded))
                : null;
          })
          .whereType<Marker>()
          .toList();

      emit(SuccessState());
    });
  }
}
