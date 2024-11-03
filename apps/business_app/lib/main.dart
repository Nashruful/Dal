import 'package:business_app/cubit/theme_cubit.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:business_app/screens/onbording_screen/onbording_screen.dart';
import 'package:business_app/services/supabase/supabase_configration.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SupabaseConfigration.connectSupabase();
  await setup();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          child: const MainApp()),
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
              home: getIt.get<DataLayer>().businessId == null
                  ? const OnboardingScreen()
                  : const BottomNavBarScreen());
        },
      ),
    );
  }
}
