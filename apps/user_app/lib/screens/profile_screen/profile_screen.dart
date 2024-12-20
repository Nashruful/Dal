import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/theme_cubit.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/auth_screens/login_screen.dart';
import 'package:user_app/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:user_app/screens/profile_screen/bloc/profile_bloc_bloc.dart';
import 'package:user_app/setup/setup.dart';
//
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
                            return ProfileInfoSection(
                              imgurl: bloc.image,
                              firstName: bloc.firstName,
                              lastName: bloc.lastName,
                              email: bloc.email,
                              child: IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Theme.of(context).indicatorColor),
                                  iconSize: 18,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfileScreen()))
                                        .then((value) {
                                      if (value != null) {
                                        bloc.add(GetInfoEvent());
                                      }
                                    });
                                  }),
                            );
                          },
                        ),
                      ),
                      const Divider(height: 40),
                      BlocBuilder<ProfileBlocBloc, ProfileBlocState>(
                        builder: (context, state) {
                          return FilterSection(
                            selectFilter: (string) {
                              bloc.add(UpdateFilterEvent(category: string));
                            },
                            categories: bloc.categories,
                            text: 'My filters'.tr(),
                            subText: 'Press to add or remove filter'.tr(),
                          );
                        },
                      ),
                      const Divider(height: 40),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return AppearanceSection(
                            // ignore: avoid_types_as_parameter_names
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
                            label1: 'English'.tr(),
                            label2: 'Arabic'.tr(),
                          );
                        },
                      ),
                      LogoutButton(
                        onPressed: () {
                          getIt.get<DataLayer>().logOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
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
