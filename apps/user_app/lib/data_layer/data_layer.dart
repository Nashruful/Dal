import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/models/all_ads_model.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  StreamSubscription<Position>? positionStream;
  late LocationSettings locationSettings;
  Position? currentPosition;
  MapController mapController = MapController();
  final dio = Dio();

  Map? currentUserInfo;

  bool firstTime = true;

  List<Ads> allAds = [];
  List<Ads> nearbyBranches = [];
  List<Ads> liveAds = [];
  //categories lists
  List<Ads> diningCategory = [];
  List<Ads> superMarketsCategory = [];
  List<Ads> fashionCategory = [];
  List<Ads> hotelsCategory = [];
  List<Ads> gymCategory = [];

  Map<String, DateTime> lastNotificationTimes =
      {}; // Map to track notification times

  List<Ads> myReminders = [];
  Map<String, int> impressions = {};
  Map<String, int> clicks = {};
  List<Map<String, dynamic>> adData = [];
  String? userId;
  Map<String, dynamic> categories = {
    'Grocery': true,
    'Dining': true,
    'Gym': true,
    'Fashion': true,
    'Hotels': true,
  };

  final box = GetStorage();

  List<Map<String, dynamic>>? adS;

  DataLayer() {
    // box.erase();

    loadData();
  }

  getAllAds() async {
    adS = await supabase.from("ad").select(
        '*,branch(*,business(*))'); // select all ads , their branches and business
    allAds.clear();
    liveAds.clear();
    nearbyBranches.clear();
    for (var element in adS!) {
      allAds.add(Ads.fromJson(element));
    }

    liveAds = allAds.where((ad) {
      DateTime endDate = DateTime.parse(ad.enddate!);
      return endDate.isAfter(DateTime.now());
    }).toList();
  }

  locationBgStream({BuildContext? context}) async {
    positionStream?.cancel();
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          forceLocationManager: true,
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    currentPosition =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      print(position?.latitude);
      if (position != null) {
        currentPosition = position;
      }

      final Map storedTimes = box.read('lastNotificationTimes') ?? {};
      lastNotificationTimes =
          storedTimes.map((key, value) => MapEntry(key, DateTime.parse(value)));

      for (var location in liveAds) {
        double distance = Geolocator.distanceBetween(
          position!.latitude,
          position.longitude,
          location.branch!.latitude!,
          location.branch!.longitude!,
        );
        final currentCategory = location.category!.toString();

        if (distance <= 1000 && categories[currentCategory] == true) {
          String branchId = location.branch!.id!; // store branches ID
          DateTime now = DateTime.now();
          DateTime? lastNotificationTime = lastNotificationTimes[branchId];

          if (lastNotificationTime == null ||
              now.difference(lastNotificationTime).inHours >= 12) {
            try {
              await dio.post(
                "https://api.onesignal.com/api/v1/notifications",
                data: {
                  "app_id": dotenv.env["ONE_SIGNAL_APP_ID"].toString(),
                  "contents": {
                    "en":
                        "Check out ${location.branch!.business!.name!} offer nearby! 📣",
                    "ar": "لا يطوفك عرض ${location.branch!.business!.name!}! 📣"
                  },
                  "include_external_user_ids": [supabase.auth.currentUser!.id],
                  "data": {
                    "page": "/offer_details",
                    "offer_id": location.id!.toString(),
                  },
                },
                options: Options(headers: {
                  "Authorization": dotenv.env["AUTH_NOTIFICATION"].toString(),
                  'Content-Type': 'application/json',
                }),
              );

              lastNotificationTimes[branchId] =
                  now; // Update the last notification time
            } on DioException catch (_) {
            } catch (_) {}
          }
        }
      }

      // Save the last notification times to GetStorage
      final Map serializedTimes = lastNotificationTimes
          .map((key, value) => MapEntry(key, value.toIso8601String()));

      box.write('lastNotificationTimes', serializedTimes);
    });
  }

  getNearbyOffers() async {
    for (var element in liveAds) {
      // get nearby branches to the user
      double distance = Geolocator.distanceBetween(
          currentPosition!.latitude,
          currentPosition!.longitude,
          element.branch!.latitude!,
          element.branch!.longitude!);
      if (distance < 1000) {
        nearbyBranches.add(element);
      }
    }

    for (var element in liveAds) {
      switch (element.category) {
        case "Dining":
          diningCategory.add(element);

          break;
        case "Supermarkets":
          superMarketsCategory.add(element);
          break;
        case "Fashion":
          fashionCategory.add(element);
          break;
        case "Hotels":
          hotelsCategory.add(element);
          break;
        case "Gym":
          gymCategory.add(element);
          break;

        default:
          break;
      }
    }
  }

  String getRemainingTime(String dateString) {
    //parse targettime
    DateTime targetDate = DateTime.parse(dateString);

// Calculate the difference
    Duration difference = targetDate.difference(DateTime.now());

// Get the remaining days
    int remainingDays = difference.inDays;
    if (remainingDays < 0) {
      remainingDays = 0;
    }
    return remainingDays.toString();
  }

  getUserInfo() async {
    userId = supabase.auth.currentUser!.id;
    currentUserInfo =
        await supabase.from("users").select().eq("id", userId!).single();

    box.write("currentUser", userId);
  }

  //increment
  recordImpressions(String adID) {
    impressions[adID] = (impressions[adID] ?? 0) + 1;
  }

  recordClicks(String adID) {
    clicks[adID] = (clicks[adID] ?? 0) + 1;
  }

  sendAdsData() async {
    for (var adId in impressions.keys) {
      await supabase.from("ad").update({
        "views": impressions[adId],
        "clicks": clicks[adId] ?? 0,
      }).eq('id', adId);
    }

    //call it whenever records has been sent
    adData = [];
    cleanImpressions();
    cleanClicks();
  }

  cleanImpressions() {
    impressions = {};
  }

  cleanClicks() {
    clicks = {};
  }

  saveCategories() {
    box.write('categories', categories);
  }

  loadData() {
    if (box.hasData('currentUser')) {
      userId = box.read('currentUser');
      getUserInfo();
    }
    if (box.hasData('categories')) {
      categories = box.read('categories');
    }
  }

  logOut() {
    saveCategories();
    supabase.auth.signOut();
    currentUserInfo = null;
    box.remove("currentUser");
    OneSignal.logout();
  }

  bool isLoggedIn() {
    if (box.hasData("currentUser")) {
      return true;
    } else {
      return false;
    }
  }
}
