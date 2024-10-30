import 'package:business_app/screens/add_ads_screen/add_ads_screen.dart';
import 'package:business_app/screens/my_ads_screen/cubit/my_ads_cubit.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'current_ads.dart';
import 'custom_tabbar.dart';
import 'past_ads.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAdsCubit(),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(
              title: "My Ads",
              bottom: MyAdsTabBar(),
              automaticallyImplyLeading: false,
            ),
            body: BlocConsumer<MyAdsCubit, MyAdsState>(
              listener: (BuildContext context, MyAdsState state) {
                if (state is LoadingAdsState) {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            content: Center(child: CircularProgressIndicator()),
                          ));
                }
                if (state is SuccessDeleteState) {
                  print('------SuccessState');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('success')));
                }
                if (state is AdErrorState) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('error')));
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAdsScreen()));
              },
              backgroundColor: const Color(0xffA51361),
              child: Icon(Icons.add, color: Colors.white),
              shape: const CircleBorder(),
            ),
          ),
        );
      }),
    );
  }
}
