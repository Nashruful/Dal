import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'current_ads.dart';
import 'custom_tabbar.dart';
import 'past_ads.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String planEndDate =
        getIt.get<DataLayer>().latestSubscription['end_date'] ?? '';
    DateTime currentDate = DateTime.now();

    return BlocProvider(
      create: (context) => MyAdsCubit(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              height: 100,
              title: "My Ads",
              bottom: MyAdsTabBar(),
              automaticallyImplyLeading: false,
            ),
            body: BlocConsumer<MyAdsCubit, MyAdsState>(
              listener: (BuildContext context, MyAdsState state) {
                if (state is LoadingAdsState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content:
                          Lottie.asset(height: 30, 'assets/json/loading.json'),
                    ),
                  );
                }
                if (state is SuccessDeleteState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Deleted Ad Successfully')),
                  );
                }
                if (state is AdErrorState) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustemErrorDialog(msg: '');
                    },
                  );
                }
              },
              builder: (context, state) {
                return const TabBarView(
                  children: [
                    CurrentAds(),
                    PastAdsTab(),
                  ],
                );
              },
            ),
            floatingActionButton: (planEndDate.isEmpty ||
                    DateTime.tryParse(planEndDate)?.isBefore(currentDate) ==
                        true)
                ? null // Do not show the button
                : FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddAdsScreen()),
                      );
                    },
                    backgroundColor: AppColors().pink,
                    child: Icon(
                      Icons.add,
                      color: AppColors().white1,
                    ),
                    shape: const CircleBorder(),
                  ),
          ),
        );
      }),
    );
  }
}
