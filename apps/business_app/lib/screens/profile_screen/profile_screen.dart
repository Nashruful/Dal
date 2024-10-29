import 'package:business_app/screens/profile_screen/bloc/profile_bloc_bloc.dart';
import 'package:business_app/screens/subscriptions_screen/subscriptions_screen.dart';
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
          appBar: AppBar(), //put cutom bar here
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
                        child: ProfileInfoSection(
                          imgurl: '',
                          firstName: 'First',
                          lastName: "Last",
                          email: 'example@example.com',
                          onPressed: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => ,))
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
                                  builder: (context) => SubscriptionsScreen()));
                        },
                        text: 'subscription one month'.tr(),
                        daytext: 'Day'.tr(),
                        remainingDay: 'Remain'.tr(),
                        subscription: 'New Subscription button'.tr(),
                      ),
                      const Divider(height: 40),
                      BlocBuilder<ProfileBlocBloc, ProfileBlocState>(
                        builder: (context, state) {
                          return AppearanceSection(
                            onChanged: (bool) {
                              bloc.add(ChangeModeEvent());
                            },
                            isOn: bloc.DarkModeOn,
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
