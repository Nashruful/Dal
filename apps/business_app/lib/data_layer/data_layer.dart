import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  Map? currentUserInfo;

  final box = GetStorage();

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("business")
        .select()
        .eq("id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }
}
