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
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xffA51361),
              onPressed: () {},
              child: const Icon(
                Icons.radar_rounded,
                color: Color(0xffF7F7F7),
                size: 36,
              ),
            ),
            body: BlocBuilder<DiscoverBloc, DiscoverState>(
              builder: (context, state) {
                if (state is SuccessState) {
                  return Stack(children: [
                    FlutterMap(
                      options: MapOptions(
                          onTap: (tapPosition, point) {
                            print("${point.latitude},${point.longitude}");
                          },
                          initialCenter: bloc.initialCenter),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: bloc.filteredMarkers),
                        MarkerLayer(markers: [
                          Marker(
                              point: bloc.initialCenter,
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xffA51361),
                                        width: 3)),
                                child: Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff8E1254),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ))
                        ]),
                        const CircleLayer(circles: [
                          CircleMarker(
                              color: Colors.amberAccent,
                              point:
                                  LatLng(31.22832604830012, 121.48968954763458),
                              radius: 30),
                        ]),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              strokeWidth: 3,
                              points: [
                                const LatLng(
                                    31.226891523501784, 121.47566444666158),
                                const LatLng(
                                    31.26946183416392, 121.46971902537194),
                                const LatLng(
                                    31.250493360622873, 121.45279743668657),
                              ],
                              color: const Color(0x80FF0000),
                              borderColor: Colors.amber,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 2.5,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none),
                                hintText: "Where to?",
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Color(0x657B7B7B)),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0x757B7B7B),
                                ),
                                filled: true,
                                fillColor: const Color(0xffEAEAEA),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.format_list_bulleted_rounded,
                                    size: 24,
                                    color: Color(0x757B7B7B),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ])
                  ]);
                }
                return const CircularProgressIndicator();
              },
            ));
      }),
    );
  }
}
