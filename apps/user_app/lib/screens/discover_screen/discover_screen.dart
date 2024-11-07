// ignore_for_file: use_build_context_synchronously

import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
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
        getIt.get<DataLayer>().positionStream!.cancel();
        try {
          LocationSettings locationSettings = const LocationSettings(
              distanceFilter: 100, accuracy: LocationAccuracy.high);
          getIt.get<DataLayer>().positionStream =
              Geolocator.getPositionStream(locationSettings: locationSettings)
                  .listen((Position position) {
            bloc.add(LoadScreenEvent(position: position, context: context));
            bloc.add(
                SendNotificationEvent(position: position, context: context));
          });
        } catch (e) {
          bloc.add(ErrorScreenEvent(msg: e.toString()));
        }

        return Scaffold(

            // YOU'LL REGRET DISABLING THIS AMAZING FEATURE!! vv

            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: BlocBuilder<DiscoverBloc, DiscoverState>(
            //   builder: (context, state) {
            //     return Padding(
            //       padding: const EdgeInsets.only(bottom: 100),
            //       child: FloatingActionButton(
            //         shape: const CircleBorder(),
            //         backgroundColor: AppColors().black2,
            //         onPressed: () {
            //           bloc.buttonClicked = !bloc.buttonClicked;
            //           bloc.add(LoadScreenEvent(
            //               position: bloc.positionn, context: context));
            //         },
            //         child: Icon(
            //           Icons.radar_rounded,
            //           color:
            //               Color(bloc.buttonClicked ? 0x30F7F7F7 : 0xffF7F7F7),
            //           size: 36,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            body: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Stack(children: [
                FlutterMap(
                  options: MapOptions(
                      onTap: (tapPosition, point) {},
                      initialZoom: 14,
                      initialCenter: LatLng(
                          bloc.positionn?.latitude ?? 24.82741851222009,
                          bloc.positionn?.longitude ?? 46.754407525179346)),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: bloc.filteredMarkers),
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
                                    color: const Color(0xffA51361), width: 3)),
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
                                  color: AppColors().white1,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                CustomText(
                                    text: "Where to?".tr(),
                                    color: AppColors().white1,
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
            return Center(
              child: lottie.Lottie.asset('assets/json/loading.json', width: 30),
            );
          },
        ));
      }),
    );
  }
}
