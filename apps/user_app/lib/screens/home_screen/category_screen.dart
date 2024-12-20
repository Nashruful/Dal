import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:impression/impression.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/models/all_ads_model.dart';
import 'package:user_app/setup/setup.dart';

class CategoryScreen extends StatelessWidget {
  final List<Ads> categoryList;

  const CategoryScreen({
    super.key,
    required this.categoryList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: categoryList.isNotEmpty
            ? Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(initialZoom: 11.8,
                        initialCenter: LatLng(categoryList[0].branch!.latitude!,
                            categoryList[0].branch!.longitude!)),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                          markers: categoryList
                              .map((e) => Marker(
                                  width: 50,
                                  height: 50,
                                  point: LatLng(e.branch!.latitude!,
                                      e.branch!.longitude!),
                                  child: ImpressionDetector(
                                    impressedCallback: () {
                                      getIt.get<DataLayer>().recordImpressions(e
                                          .id!); //add impressions to ad id each time it is viewed
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        getIt.get<DataLayer>().recordClicks(e
                                            .id!); //add impressions to ad id each time it is clicks
                                        String categoryIcon =
                                            e.category!.toString();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  content: BottomSheetForMap(
                                                      locationOnPressed:
                                                          () async {
                                                        final availableMaps =
                                                            await MapLauncher
                                                                .installedMaps;

                                                        if (availableMaps
                                                            .isNotEmpty) {
                                                          await availableMaps
                                                              .first
                                                              .showMarker(
                                                            coords: Coords(
                                                                e.branch!
                                                                    .latitude!,
                                                                e.branch!
                                                                    .longitude!),
                                                            title: e
                                                                .branch!
                                                                .business!
                                                                .name!,
                                                          );
                                                        } else {
                                                          // Handle the case where no maps are installed

                                                          ScaffoldMessenger.of(
                                                                  // ignore: use_build_context_synchronously
                                                                  context)
                                                              .showSnackBar(
                                                             SnackBar(
                                                                content: Text(
                                                                    'No maps are installed on this device.'.tr())),
                                                          );
                                                        }
                                                      },
                                                      image: e.bannerimg!,
                                                      companyName: e.branch!
                                                          .business!.name!,
                                                      iconImage:
                                                          "assets/svg/$categoryIcon.svg",
                                                      description:
                                                          e.description!,
                                                      remainingDay: getIt
                                                          .get<DataLayer>()
                                                          .getRemainingTime(
                                                              e.enddate!),
                                                      offerType: e.offerType!,
                                                      viewLocation:
                                                          "View Location".tr()),
                                                ));
                                      },
                                      child: Badge(
                                        label: Text(
                                          "${e.offerType}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 3,
                                                  color: Colors.white)),
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                            child: Image.network(
                                              fit: BoxFit.fill,
                                              e.branch!.business!.logoImg!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )))
                              .toList()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                            size: 40, color: Colors.red, Icons.close_rounded)),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No data available for this category.."),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomElevatedButton(
                        backgroundColor: Colors.grey.shade300,
                        onPressed: () => Navigator.pop(context),
                        child: CustomText(
                            text: "Go back".tr(), color: Colors.black, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ));
  }
}
