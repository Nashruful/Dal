import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  Position? position;
  final LatLng initialCenter = LatLng(24.82307363899628, 46.76960924937112);
    LatLng currentLocation = LatLng(24.82307363899628, 46.76960924937112);

  // List of provided markers
  final List<LatLng> markerLocations = [
    LatLng(24.81307299899741, 46.76503970781533),
    LatLng(24.82037851123455, 46.76296974609059),
    LatLng(24.81924369998163, 46.77445218221551),
    LatLng(24.835059154264727, 46.77699081816699),
    LatLng(24.83317984725718, 46.7532448270556),
  ];

  List<Marker> filteredMarkers = [];
  DiscoverBloc() : super(DiscoverInitial()) {
    on<DiscoverEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      final LocationSettings locationSettings = LocationSettings();
      position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
          
    

    // Create markers from the provided locations and filter them
    filteredMarkers = markerLocations
        .map((location) {
          double distance = Geolocator.distanceBetween(
            currentLocation.latitude,
            currentLocation.longitude,
            location.latitude,
            location.longitude,
          );

          // Only include markers within 300 meters
          return distance <= 1000
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