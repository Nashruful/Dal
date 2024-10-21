import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;

  Map? currentUserInfo;

  final box = GetStorage();

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("user_id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }
}
