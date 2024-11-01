import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/models/all_ads_model.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  Map? currentUserInfo;
  List<Ads> allAds = [];
  List<Map<String, dynamic>> myReminders = [];
  Map<String, int> impressions = {};
  Map<String, int> clicks = {};
  List<Map<String, dynamic>> adData = [];

  final box = GetStorage();

  List businessBranches = [];
  List allbusinessAds = [];
  List<Map<String, dynamic>>? adS;

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
    // log("-----------------branches $businessBranches");

    for (var element in allAds!) {
      allbusinessAds.add(element);
    }
    // print('-------ads: $allbusinessAds');

    //  box.write("currentUser", currentBusinessInfo);
  }

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }

  //increment
  recordImpressions(String adID) {
    impressions[adID] = (impressions[adID] ?? 0) + 1;
    // print(impressions);
  }

  recordClicks(String adID) {
    clicks[adID] = (clicks[adID] ?? 0) + 1;
  }

  sendAdsData() async {
    // for (var adId in impressions.keys) {
    //   adData.add({
    //     "id": adId,
    //     "impressions": impressions[adId],
    //     "clicks": clicks[adId] ?? 0,
    //   });
    // }

    // await supabase.from("ad").upsert(adData);

    // //call it whenever records has been sent
    // adData = [];
    // cleanImpressions();
    // cleanClicks();
  }

  cleanImpressions() {
    impressions = {};
  }

  cleanClicks() {
    clicks = {};
  }
}
