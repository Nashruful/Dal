import 'package:components/component/theme/theme.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:user_app/cubit/theme_cubit.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:user_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:user_app/services/supabase/supabase_configration.dart';
import 'package:user_app/setup/setup.dart';
import 'package:lifecycle/lifecycle.dart';

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
          //fallbackLocale: Locale('en', 'US'),
          child: const MainApp()), // Wrap your app
    ),
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("ebdec5c2-30a4-447d-9577-a1c13b6d553e");

  OneSignal.Notifications.requestPermission(true);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with LifecycleAware, LifecycleMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isLogin = getIt.get<DataLayer>();
          return MaterialApp(
            navigatorObservers: [defaultLifecycleObserver],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state.themeData,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            home: LifecycleWrapper(
                onLifecycleEvent: (LifecycleEvent event) async {
                  if (event == LifecycleEvent.invisible) {
                    //when user stop using app
                    await getIt
                        .get<DataLayer>()
                        .getAllAds(); //update live ads list
                    for (var adId in getIt.get<DataLayer>().impressions.keys) {
                      print('clicks in list');
                      print(getIt.get<DataLayer>().clicks[adId]);

                      await getIt
                          .get<DataLayer>()
                          .supabase
                          .rpc('increment_ad_views', params: {
                        'ad_id': adId,
                        'increment_views_by':
                            getIt.get<DataLayer>().impressions[adId],
                        'increment_clicks_by':
                            getIt.get<DataLayer>().clicks[adId] ?? 0
                      });
                    }
                    getIt.get<DataLayer>().impressions = {}; //clear map
                    getIt.get<DataLayer>().clicks = {}; //clear map
                  }
                },
                child: isLogin.isLoggedIn()
                    ? const BottomNavBarScreen()
                    : const OnboardingScreen()),
          );
        },
      ),
    );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {}
}
