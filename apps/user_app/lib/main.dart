import 'package:flutter/material.dart';
import 'package:user_app/screens/home_screen/home_screen.dart';
import 'package:user_app/screens/auth_screens/login_screen.dart';

import '../../business_app/lib/subscriptions_screen/subscriptions_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MainApp(), // Wrap your app
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscriptionsScreen(),
    );
  }
}
