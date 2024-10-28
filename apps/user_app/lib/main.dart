import 'package:components/component/theme/theme.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/theme_cubit.dart';
import 'package:user_app/screens/auth_screens/create_account_screen.dart';
import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:user_app/screens/home_screen/home_screen.dart';
import 'package:user_app/services/supabase/supabase_configration.dart';
import 'package:user_app/setup/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SupabaseConfigration.connectSupabase();
  await setup();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          //fallbackLocale: Locale('en', 'US'),
          child: const MainApp()), // Wrap your app
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: state.themeData,
              darkTheme: AppThemes.darkTheme,
              themeMode: ThemeMode.system,
              home: BottomNavBarScreen(),
            );
        },
      ),
    );
  }
}
