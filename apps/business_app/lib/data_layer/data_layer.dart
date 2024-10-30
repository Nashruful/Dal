import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

//initially save categories here
  Map<int, String> categories = {
    0: 'Cafes',
    1: 'Bakery',
    2: 'Breakfast',
    3: 'Ice creams',
    4: 'Dining',
    5: 'Drinks',
  };
  final box = GetStorage();
  String? businessId;
  List currentBusinessInfo = [];
  List businessBranches = [];
  List allbusinessAds = [];

//call this func to refresh
  getBusinessInfo() async {
    currentBusinessInfo = await supabase
        .from('business')
        .select(
            '*, branch(*,ad(*))') // Select all from business, branch, and ad
        .eq('id', businessId!); // change with incomming businessId

    businessBranches =
        currentBusinessInfo[0]['branch']; //save branches into a seperate list
    //print('-------branchs $businessBranches');
    allbusinessAds = [];
    businessBranches.forEach((branch) {
      List ads = branch['ad']; // Get the list of ads for the current branch
      allbusinessAds.addAll(ads);
    });
    print('-------ads: $allbusinessAds');

    //  box.write("currentUser", currentBusinessInfo);
  }
}
