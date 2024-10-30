import 'package:business_app/cubit/theme_cubit.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/profile_screen/bloc/profile_bloc_bloc.dart';
import 'package:business_app/screens/subscriptions_screen/subscriptions_screen.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBlocBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<ProfileBlocBloc>();
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: 'Profile'.tr(),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: BlocBuilder<ProfileBlocBloc, ProfileBlocState>(
                          builder: (context, state) {
                            final businessInfo =
                                getIt.get<DataLayer>().currentBusinessInfo;
                            ;
                            return ProfileInfoSection(
                              imgurl: getIt
                                  .get<DataLayer>()
                                  .currentBusinessInfo[0]['logo_img'],
                              firstName: businessInfo[0]['name'],
                              email: businessInfo[0]['email'],
                              child: const SizedBox.shrink(),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 40),
                      PlanSection(
                        plan: 'Basic'.tr(),
                        planDesc: 'Basic description'.tr(),
                        endDate: "${'End ads'.tr()} 11/11/2030",
                        remainDays: 11,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SubscriptionsScreen()));
                        },
                        text: 'subscription one month'.tr(),
                        daytext: 'Day'.tr(),
                        remainingDay: 'Remain'.tr(),
                        subscription: 'New Subscription button'.tr(),
                      ),
                      const Divider(height: 40),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return AppearanceSection(
                            onChanged: (bool) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                            isOn: context.read<ThemeCubit>().DarkModeOn,
                            text: 'Appearance'.tr(),
                            darkText: 'Dark Mode'.tr(),
                            lightText: 'Light Mode'.tr(),
                          );
                        },
                      ),
                      const Divider(height: 40),
                      BlocBuilder<ProfileBlocBloc, ProfileBlocState>(
                        builder: (context, state) {
                          return LanguageSection(
                            changeLang: (int? value) {
                              switch (value) {
                                case 0:
                                  context.setLocale(const Locale('en'));
                                  break;
                                case 1:
                                  context.setLocale(const Locale('ar'));
                                  break;
                              }
                              bloc.add(ChangeLangEvent(value: value!));
                            },
                            value: bloc.langValue,
                            text: 'Language'.tr(),
                            label: 'English'.tr(),
                          );
                        },
                      ),
                      LogoutButton(
                        onPressed: () {
                          //
                        },
                        text: 'Log out'.tr(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
