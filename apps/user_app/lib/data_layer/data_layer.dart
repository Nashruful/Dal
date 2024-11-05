import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/models/all_ads_model.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  Map? currentUserInfo;

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
    'Supermarkets': true,
    'Dining': true,
    'Gym': true,
    'Fashion': true,
    'Hotels': true,
  };

  final box = GetStorage();

  List businessBranches = [];
  List allbusinessAds = [];
  List<Map<String, dynamic>>? adS;

  DataLayer() {
    //box.erase();
    //box.write("islogin", true);
    loadData();
    print(categories);
  }

//call this func to refresh
  getAllAds() async {
    adS = await supabase.from("ad").select(
        '*,branch(*,business(*))'); // select all ads , their branches and business
    for (var element in adS!) {
      allAds.add(Ads.fromJson(element));
    }
    businessBranches = await supabase
        .from("branch")
        .select("*,business(*)"); // select branches to show them on map

    liveAds = allAds.where((ad) {
      DateTime startDate = DateTime.parse(ad.startdate!);
      DateTime endDate = DateTime.parse(ad.enddate!);
      DateTime now = DateTime.now();
      return now.isAfter(startDate) && now.isBefore(endDate);
    }).toList();

    // for (var element in allAds) {
    //   allbusinessAds.add(element);
    // }
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
