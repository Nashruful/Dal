import 'package:components/component/theme/theme.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:user_app/cubit/theme_cubit.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:user_app/screens/home_screen/notification_clicked_screen.dart';
import 'package:user_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:user_app/services/supabase/supabase_configration.dart';
import 'package:user_app/setup/setup.dart';
import 'package:lifecycle/lifecycle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SupabaseConfigration.connectSupabase();
  await setup();

  // await FlutterBackground.initialize(
  //   androidConfig: const FlutterBackgroundAndroidConfig(
  //     notificationTitle: "App is running in the background",
  //     notificationText: "Location tracking is active",
  //     notificationIcon: AndroidResource(name: 'ic_launcher', defType: 'mipmap'),
  //   ),
  // );

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
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(dotenv.env["ONE_SIGNAL_APP_ID"].toString());

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
    final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
    OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
      if (event.notification.additionalData != null) {
        navKey.currentState!.pushNamed(
            event.notification.additionalData!['page'],
            arguments: event.notification.additionalData!['offer_id']);
      }
    });
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isLogin = getIt.get<DataLayer>();
          return MaterialApp(
              navigatorKey: navKey,
              initialRoute: "/",
              navigatorObservers: [defaultLifecycleObserver],
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: state.themeData,
              darkTheme: AppThemes.darkTheme,
              themeMode: ThemeMode.system,
              routes: {
                "/": (context) => LifecycleWrapper(
                    onLifecycleEvent: (LifecycleEvent event) async {
                      if (event == LifecycleEvent.invisible) {
                        
                        //when user stop using app
                        await getIt
                            .get<DataLayer>()
                            .getAllAds(); //update live ads list
                         getIt
                            .get<DataLayer>()
                            .locationBgStream(); //update live ads list
                        final impressionKeys =
                            List.from(getIt.get<DataLayer>().impressions.keys);

                        for (var adId in impressionKeys) {
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
                "/offer_details": (context) => LifecycleWrapper(
                    onLifecycleEvent: (LifecycleEvent event) async {
                      if (event == LifecycleEvent.invisible) {
                        //when user stop using app
                        await getIt
                            .get<DataLayer>()
                            .getAllAds(); //update live ads list
                         getIt
                            .get<DataLayer>()
                            .locationBgStream(); //update live ads list
                        final impressionKeys =
                            List.from(getIt.get<DataLayer>().impressions.keys);

                        for (var adId in impressionKeys) {
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
                    child: const NotificationClickedScreen())
              });
        },
      ),
    );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {}
}
