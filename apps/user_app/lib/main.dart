import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:user_app/screens/auth_screens/create_account_screen.dart';
import 'package:user_app/screens/auth_screens/verify_screen.dart';
import 'package:user_app/services/supabase/supabase_configration.dart';
import 'package:user_app/setup/setup.dart';

void main() async {
  await SupabaseConfigration.connectSupabase();
  await setup();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(), // Wrap your app
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerifyScreen(),
    );
  }
}
