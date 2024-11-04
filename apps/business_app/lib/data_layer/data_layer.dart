import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  DataLayer() {
    loadData();
  }

  final supabase = Supabase.instance.client;
  final box = GetStorage();

//initially save categories here
  Map<int, String> categories = {
    0: 'Supermarkets',
    1: 'Dining',
    2: 'Gym',
    3: 'Fashion',
    4: 'Hotels',
  };

  String? businessId;
  List currentBusinessInfo = [];
  List businessBranches = [];
  List allbusinessAds = [];
  Map latestSubscription = {};
  // ignore: non_constant_identifier_names
  List subscription_business = [];

  loadData() {
    if (box.hasData("BusinessID")) {
      businessId = box.read('BusinessID');
      getBusinessInfo();
    }
    box.read('language');
  }

//call this func to refresh
  getBusinessInfo() async {
    currentBusinessInfo = await supabase
        .from('business')
        .select(
            '*, branch(*,ad(*)), subscription_business(*)') // Select all from business, branch, and ad
        .eq('id', businessId!); // change with incomming businessId
    businessBranches =
        currentBusinessInfo[0]['branch']; //save branches into a seperate list

    allbusinessAds = []; //clear ads

    for (var branch in businessBranches) {
      List ads = branch['ad']; // Get the list of ads for for Each branch
      allbusinessAds.addAll(ads);
    }
    // subscription_business = currentBusinessInfo[0]['subscription_business'] ??
    //     [];
    subscription_business = currentBusinessInfo[0]['subscription_business'];
    // subscription_business = [];
    // subscription_business.isNotEmpty
    //     ? latestSubscription =
    //         subscription_business.last //save last sub subscription plan
    //     : null;

    if (subscription_business.isNotEmpty) {
      latestSubscription = subscription_business.last;
    } else {
      latestSubscription = {};
      //null;
    }

    box.write("BusinessID", businessId); // save on login or refresh
  }

  logout() {
    box.erase();
  }
}
