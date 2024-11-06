import 'package:avatar_glow/avatar_glow.dart';
import 'package:components/component/bottom_sheet_for_map/bottom_sheet_for_map.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:impression/impression.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/models/all_ads_model.dart';
import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:user_app/setup/setup.dart';

class NotificationClickedScreen extends StatelessWidget {
  const NotificationClickedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final branchId = ModalRoute.of(context)!.settings.arguments;
    final Ads adFromNotification =
        getIt.get<DataLayer>().liveAds.firstWhere((e) => e.id == branchId);
    return Scaffold(
        body: Stack(
      children: [
        FlutterMap(
          options: MapOptions(
              initialCenter: LatLng(adFromNotification.branch!.latitude!,
                  adFromNotification.branch!.longitude!)),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: [
              Marker(
                  width: 50,
                  height: 50,
                  point: LatLng(adFromNotification.branch!.latitude!,
                      adFromNotification.branch!.longitude!),
                  child: ImpressionDetector(
                    impressedCallback: () {
                      getIt.get<DataLayer>().recordImpressions(adFromNotification
                          .id!); //add impressions to ad id each time it is viewed
                    },
                    child: InkWell(
                      onTap: () {
                        getIt.get<DataLayer>().recordClicks(adFromNotification
                            .id!); //add impressions to ad id each time it is clicks
                        String categoryIcon =
                            adFromNotification.category!.toString();
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: BottomSheetForMap(
                                      locationOnPressed: () async {
                                        final availableMaps =
                                            await MapLauncher.installedMaps;

                                        if (availableMaps.isNotEmpty) {
                                          await availableMaps.first.showMarker(
                                            coords: Coords(
                                                adFromNotification
                                                    .branch!.latitude!,
                                                adFromNotification
                                                    .branch!.longitude!),
                                            title: adFromNotification
                                                .branch!.business!.name!,
                                          );
                                        } else {
                                          // Handle the case where no maps are installed

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                             SnackBar(
                                                content: Text(
                                                    'No maps are installed on this device.'.tr())),
                                          );
                                        }
                                      },
                                      image: adFromNotification.bannerimg!,
                                      companyName: adFromNotification
                                          .branch!.business!.name!,
                                      iconImage: "assets/svg/$categoryIcon.svg",
                                      description:
                                          adFromNotification.description!,
                                      remainingDay: getIt
                                          .get<DataLayer>()
                                          .getRemainingTime(
                                              adFromNotification.enddate!),
                                      offerType: adFromNotification.offerType!,
                                      viewLocation: "View Location".tr()),
                                ));
                      },
                      child: Badge(
                        label: Text(
                          "${adFromNotification.offerType}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        child: AvatarGlow(
                          glowColor: Colors.redAccent,
                          repeat: true,
                          glowShape: BoxShape.circle,
                          glowRadiusFactor: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 3, color: Colors.white)),
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              child: Image.network(
                                fit: BoxFit.fill,
                                adFromNotification.branch!.business!.logoImg!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ]),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBarScreen()));
              },
              icon:
                  const Icon(size: 40, color: Colors.red, Icons.close_rounded)),
        ),
      ],
    ));
  }
}
