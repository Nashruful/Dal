import 'package:business_app/cubit/theme_cubit.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/auth_screens/login_screen.dart';
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
//
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBlocBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<ProfileBlocBloc>();
        String getPlanType(Map currentPlan) {
          final String planType;
          if (bloc.plan['subscription_type'] == 'Basic') {
            return 'Basic'.tr();
          } else if (bloc.plan['subscription_type'] == 'Premium') {
            return 'Basic'.tr();
          } else if (bloc.plan['subscription_type'] == 'Enterprise') {
            return 'Basic'.tr();
          } else {
            planType = 'No Subscription';
          }

          return planType;
        }

        String getPlanDesc(Map currentPlan) {
          final String planDesc;
          if (bloc.plan['subscription_type'] == 'Basic') {
            planDesc = 'Basic description'.tr();
          } else if (bloc.plan['subscription_type'] == 'Premium') {
            planDesc = 'Premium description'.tr();
          } else if (bloc.plan['subscription_type'] == 'Enterprise') {
            planDesc = 'Enterprise description'.tr();
          } else {
            planDesc = 'No Data';
          }

          return planDesc;
        }

        int getRemainingDays(DateTime planEndDate) {
          DateTime currentDate = DateTime.now();
          Duration difference = planEndDate.difference(currentDate);

          int days = difference.inDays;

          if (days < 0) {
            days = 0;
          }
          return days;
        }

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
                      // profile info
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ProfileInfoSection(
                            imgurl: getIt
                                .get<DataLayer>()
                                .currentBusinessInfo[0]['logo_img'],
                            firstName: bloc.businessInfo[0]['name'],
                            lastName: '',
                            email: bloc.businessInfo[0]['email'],
                            child: const SizedBox.shrink(),
                          )),
                      const Divider(height: 40),
                      BlocConsumer<ProfileBlocBloc, ProfileBlocState>(
                        listener: (context, state) {
                          if (state is SuccessState) {
                          }
                        },
                        builder: (context, state) {
                          return PlanSection(
                            plan: getPlanType(bloc.plan),
                            planDesc: getPlanDesc(bloc.plan),
                            endDate: bloc.planEndDate == ''
                                ? ''
                                : "${'End ads'.tr()} ${DateTime.parse(bloc.planEndDate).day}/${DateTime.parse(bloc.planEndDate).month}/${DateTime.parse(bloc.planEndDate).year}",
                            remainDays: bloc.planEndDate == ''
                                ? 0
                                : getRemainingDays(
                                    DateTime.parse(bloc.planEndDate)),
                            onPressed: bloc.planEndDate == '' ||
                                    DateTime.parse(bloc.planEndDate)
                                        .isBefore(bloc.currentDate)
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscriptionsScreen(),
                                      ),
                                    ).then((_) {
                                      bloc.add(RefreshScreenEvent());
                                    });
                                  }
                                : null,
                            text: 'planTitle'.tr(),
                            daytext: 'Day'.tr(),
                            remainingDay: 'Remain'.tr(),
                            subscription: 'New Subscription button'.tr(),
                          );
                        },
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
                          getIt.get<DataLayer>().logout();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()),
                              ModalRoute.withName('/'));
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
