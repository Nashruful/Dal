import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:user_app/screens/discover_screen/bloc/discover_bloc.dart';
import 'package:user_app/screens/search_screen/search_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<DiscoverBloc>();
        try {
          const LocationSettings locationSettings = LocationSettings();
          bloc.positionStream =
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: BlocBuilder<DiscoverBloc, DiscoverState>(
              builder: (context, state) {
                return FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors().pink,
                  onPressed: () {
                    bloc.buttonClicked = !bloc.buttonClicked;
                    bloc.add(LoadScreenEvent(
                        position: bloc.positionn, context: context));
                  },
                  child: Icon(
                    Icons.radar_rounded,
                    color: Color(bloc.buttonClicked ? 0x30F7F7F7 : 0xffF7F7F7),
                    size: 36,
                  ),
                );
              },
            ),
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
                              'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: bloc.filteredMarkers),
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
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SearchScreen()));
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none),
                                hintText: "Where to?",
                                hintStyle: TextStyle(
                                    fontSize: 16, color: AppColors().grey2),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors().grey2,
                                ),
                                filled: true,
                                fillColor: Theme.of(context).canvasColor,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.format_list_bulleted_rounded,
                                    size: 24,
                                    color: AppColors().grey2,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ])
                  ]);
                }
                if (state is ErrorState) {
                  return Center(child: Text(state.msg.toString()));
                }
                return Center(
                  child: lottie.Lottie.asset('assets/json/loading.json',
                      width: 30),
                );
              },
            ));
      }),
    );
  }
}
