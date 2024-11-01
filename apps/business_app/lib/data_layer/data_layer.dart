import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

//initially save categories here
  Map<int, String> categories = {
    0: 'Markets',
    1: 'Dining',
    2: 'Gym',
    3: 'Clothes',
    4: 'Hotels',
  };
  final box = GetStorage();
  String? businessId;
  List currentBusinessInfo = [];
  List businessBranches = [];
  List allbusinessAds = [];
  List subscription_business = [];
//call this func to refresh
  getBusinessInfo() async {
    currentBusinessInfo = await supabase
        .from('business')
        .select(
            '*, branch(*,ad(*)), subscription_business(*)') // Select all from business, branch, and ad
        .eq('id', businessId!); // change with incomming businessId

    businessBranches =
        currentBusinessInfo[0]['branch']; //save branches into a seperate list
    allbusinessAds = [];

    businessBranches.forEach((branch) {
      List ads = branch['ad']; // Get the list of ads for the current branch
      allbusinessAds.addAll(ads);
    });

    subscription_business = currentBusinessInfo[0][
        'subscription_business']; //save subscription_business into a seperate list

    final latestSubscription = (subscription_business as List).isNotEmpty
        ? (subscription_business as List)
            .reduce((a, b) => a['created_at'].isAfter(b['created_at']) ? a : b)
        : null;
    print(subscription_business);
    //  box.write("currentUser", currentBusinessInfo);
  }
}
