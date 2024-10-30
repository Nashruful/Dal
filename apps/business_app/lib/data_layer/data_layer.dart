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
  List currentBusinessInfo = [];
  List businessBranches = [];
  List allbusinessAds = [];

//call this func to refresh
  getBusinessInfo() async {
    currentBusinessInfo = await supabase
        .from('business')
        .select(
            '*, branch(*,ad(*))') // Select all from business, branch, and ad
        .eq('id',
            'ffa9dfe6-6645-470f-96ab-659fa8ac3faf'); // change with incomming businessId

    businessBranches =
        currentBusinessInfo[0]['branch']; //save branches into a seperate list
    //print('-------branchs $businessBranches');

    businessBranches.forEach((branch) {
      List ads = branch['ad']; // Get the list of ads for the current branch
      allbusinessAds.addAll(ads);
    });
    print('-------ads: $allbusinessAds');

    //  box.write("currentUser", currentBusinessInfo);
  }
}
