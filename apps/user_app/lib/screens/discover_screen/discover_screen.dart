import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_app/screens/discover_screen/bloc/discover_bloc.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<DiscoverBloc>();
        bloc.add(LoadScreenEvent());
        return Scaffold(body: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Stack(children: [
                FlutterMap(
                  options: MapOptions(
                      onTap: (tapPosition, point) {
                        print("${point.latitude},${point.longitude}");
                      },
                      initialCenter: LatLng(
                          bloc.position?.latitude ?? 24.853236951003687,
                          bloc.position?.longitude ?? 46.71308977170682)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: [
                      Marker(
                          width: 100,
                          height: 100,
                          point: LatLng(
                              bloc.position?.latitude ?? 24.853236951003687,
                              bloc.position?.longitude ?? 46.71308977170682),
                          child: const Icon(
                              color: Colors.blueAccent,
                              size: 35,
                              Icons.location_on_rounded))
                    ]),
                    const CircleLayer(circles: [
                      CircleMarker(
                          color: Colors.amberAccent,
                          point: LatLng(31.22832604830012, 121.48968954763458),
                          radius: 30),
                    ]),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          strokeWidth: 3,
                          points: [
                            LatLng(31.226891523501784, 121.47566444666158),
                            LatLng(31.26946183416392, 121.46971902537194),
                            LatLng(31.250493360622873, 121.45279743668657),
                          ],
                          color: Color(0x80FF0000),
                          borderColor: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                )
              ]);
            }
            return CircularProgressIndicator();
          },
        ));
      }),
    );
  }
}