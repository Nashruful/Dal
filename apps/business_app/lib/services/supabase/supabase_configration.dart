import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfigration {
  static connectSupabase() async {
    await dotenv.load(fileName: ".env");

    await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"].toString(),
      anonKey: dotenv.env["SUPABASE_ANON_KEY"].toString(),
    );
  }

}
