import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  Map<int, String> categories = {
    0: 'Cafes',
    1: 'Bakery',
    2: 'Breakfast',
    3: 'Ice creams',
    4: 'Dining',
    5: 'Drinks',
  };


}
