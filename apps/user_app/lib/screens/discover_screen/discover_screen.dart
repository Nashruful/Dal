// ignore_for_file: use_build_context_synchronously

import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/discover_screen/bloc/discover_bloc.dart';
import 'package:user_app/screens/search_screen/search_screen.dart';
import 'package:user_app/setup/setup.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<DiscoverBloc>();
        bloc.add(LoadScreenEvent(
            position: getIt.get<DataLayer>().currentPosition,
            context: context));

        getIt.get<DataLayer>().positionStream!.onData(
          (Position data) async {
            getIt.get<DataLayer>().currentPosition = data;
            bloc.add(LoadScreenEvent(position: data, context: context));

            if (!bloc.autoTrack) {
              getIt
                  .get<DataLayer>()
                  .mapController
                  .move(LatLng(data.latitude, data.longitude), 14);
            }

            // bloc.add(SendNotificationEvent(position: data, context: context));
          },
        );

        return Scaffold(

            // YOU'LL REGRET DISABLING THIS AMAZING FEATURE!! vv

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: BlocBuilder<DiscoverBloc, DiscoverState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors().black2,
                    onPressed: () {
                      if (bloc.showButton) {
                        getIt.get<DataLayer>().mapController.move(
                            LatLng(
                                getIt
                                    .get<DataLayer>()
                                    .currentPosition!
                                    .latitude,
                                getIt
                                    .get<DataLayer>()
                                    .currentPosition!
                                    .longitude),
                            14);
                        bloc.showButton = false;
                        bloc.autoTrack = false;
                        bloc.add(UpdateScreenTrackEvent());
                      } else {
                        null;
                      }
                    },
                    child: Icon(
                      Icons.my_location,
                      color: Color(!bloc.showButton ? 0x30F7F7F7 : 0xffF7F7F7),
                      size: 36,
                    ),
                  ),
                );
              },
            ),
            body: BlocBuilder<DiscoverBloc, DiscoverState>(
              builder: (context, state) {
                if (state is SuccessState) {
                  return Stack(children: [
                    FlutterMap(
                      mapController: getIt.get<DataLayer>().mapController,
                      options: MapOptions(
                          onPositionChanged: (camera, hasGesture) {
                            if (camera.center !=
                                LatLng(
                                    getIt
                                        .get<DataLayer>()
                                        .currentPosition!
                                        .latitude,
                                    getIt
                                        .get<DataLayer>()
                                        .currentPosition!
                                        .longitude)) {
                              bloc.showButton = true;
                              bloc.autoTrack = true;
                              bloc.add(UpdateScreenTrackEvent());
                            }
                          },
                          onTap: (tapPosition, point) {},
                          initialZoom: 14,
                          initialCenter: LatLng(
                              getIt.get<DataLayer>().currentPosition!.latitude,
                              bloc.positionn!.longitude)),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: bloc.allMarkers),
                        MarkerLayer(markers: [
                          Marker(
                              point: LatLng(bloc.positionn!.latitude,
                                  bloc.positionn!.longitude),
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                    color: AppColors().white1,
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
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: AppColors().black1,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    CustomText(
                                        text: "Where to?".tr(),
                                        color: AppColors().black1,
                                        fontSize: 16)
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ])
                  ]);
                }
                if (state is ErrorState) {
                  return Center(child: Text(state.msg.toString()));
                }
                return Stack(children: [
                  FlutterMap(
                    mapController: getIt.get<DataLayer>().mapController,
                    options: MapOptions(
                        onPositionChanged: (camera, hasGesture) {
                          if (camera.center !=
                              LatLng(
                                  getIt
                                      .get<DataLayer>()
                                      .currentPosition!
                                      .latitude,
                                  getIt
                                      .get<DataLayer>()
                                      .currentPosition!
                                      .longitude)) {
                            bloc.showButton = true;
                            bloc.autoTrack = true;
                            bloc.add(UpdateScreenTrackEvent());
                          }
                        },
                        initialZoom: 14,
                        initialCenter: LatLng(
                            getIt.get<DataLayer>().currentPosition!.latitude,
                            getIt.get<DataLayer>().currentPosition!.longitude)),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(markers: bloc.allMarkers),
                      MarkerLayer(markers: [
                        Marker(
                            point: LatLng(
                                getIt
                                    .get<DataLayer>()
                                    .currentPosition!
                                    .latitude,
                                getIt
                                    .get<DataLayer>()
                                    .currentPosition!
                                    .longitude),
                            child: Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                  color: AppColors().white1,
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: AppColors().black1,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  CustomText(
                                      text: "Where to?".tr(),
                                      color: AppColors().black1,
                                      fontSize: 16)
                                ],
                              ),
                            ),
                          )),
                    ),
                  ])
                ]);
              },
            ));
      }),
    );
  }
}
