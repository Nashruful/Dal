import 'package:business_app/screens/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/screens/my_ads_screen/current_ads.dart';
import 'package:business_app/screens/my_ads_screen/custom_tabbar.dart';
import 'package:business_app/screens/my_ads_screen/past_ads.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_dialog/custom_erroe_msg.dart';
import 'package:components/component/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAdsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<MyAdsCubit>();
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar:  CustomAppBar(
              height: 100,
              title: "My Ads".tr(),
              bottom: const MyAdsTabBar(),
              automaticallyImplyLeading: false,
            ),
            body: Stack(
              children: [
                BlocConsumer<MyAdsCubit, MyAdsState>(
                  listener: (BuildContext context, MyAdsState state) {
                    if (state is LoadingAdsState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Lottie.asset(
                              height: 30, 'assets/json/loading.json'),
                        ),
                      );
                    }
                    if (state is SuccessDeleteState) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      cubit.refreshInfo();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text('Deleted Ad Successfully'.tr())),
                      );
                    }
                    if (state is AdErrorState) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const CustomErrorDialog(msg: '');
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return const TabBarView(
                      children: [
                        CurrentAdsTap(),
                        PastAdsTab(),
                      ],
                    );
                  },
                ),
                if (!(cubit.planEndDate.isEmpty ||
                    DateTime.tryParse(cubit.planEndDate)
                            ?.isBefore(cubit.currentDate) ==
                        true))
                  Positioned(
                    bottom: 90.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddAdsScreen()),
                        ).then((value) {
                          if (value != null) {
                            cubit.refreshInfo();
                          }
                        });
                      },
                      backgroundColor: AppColors().pink,
                      shape: const CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: AppColors().white1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
