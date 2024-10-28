import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  Map? currentUserInfo;
  List<Map<String, dynamic>>? allAds;
  List<Map<String, dynamic>> myReminders = [];
  Map<String, int> impressions = {};
  Map<String, int> clicks = {};

  final box = GetStorage();

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }

  //icrement
  recordImpressions(String adID) {
    impressions[adID] = (impressions[adID] ?? 0) + 1;

  }

  recordClicks(String adID) {
        clicks[adID] = (clicks[adID] ?? 0) + 1;
  }
  cleanImpressions() {}
  cleanClicks() {}
}
