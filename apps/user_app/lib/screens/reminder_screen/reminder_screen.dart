import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:components/component/custom_containers/custom_ads_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impression/impression.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/setup/setup.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blockContext) => HomeCubit(),
      child: Builder(
        builder: (blockContext) {
          return Scaffold(
              appBar: const CustomAppBar(
                  title: 'My Reminders', automaticallyImplyLeading: false),
              body: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: getIt.get<DataLayer>().myReminders.length,
                      itemBuilder: (context, index) {
                        final item = getIt.get<DataLayer>().myReminders[index];
                        return CustomAdsContainer(
                          companyLogo: item.branch!.business!.logoImg ??
                              "https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/user%20profile%20images/images/defualt_profile_img.png?t=2024-11-03T13%3A11%3A13.024Z",
                          remainingDay:
                              "${getIt.get<DataLayer>().getRemainingTime(item.enddate!)}d",
                          companyName: item.branch!.business!.name ?? "----",
                          offers: '${item.offerType!} ${'off'.tr()}',
                          onTap: () {
                            String currentLogo = item.category!.toString();
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ImpressionDetector(
                                    impressedCallback: () {
                                      getIt.get<DataLayer>().recordClicks(item
                                          .id!); //add clicks to ad id each time it is viewed
                                    },
                                    child: CustomBottomSheet(
                                      image: item.bannerimg!,
                                      companyName:
                                          item.branch!.business!.name ?? "---",
                                      iconImage: 'assets/svg/$currentLogo.svg',
                                      description: item.description ?? "---",
                                      remainingDay:
                                          "${getIt.get<DataLayer>().getRemainingTime(item.enddate!)}d",
                                      offerType: item.offerType!,
                                      viewLocation: 'View Location'.tr(),
                                      locationOnPressed: () {
                                        //
                                      },
                                      button: context
                                          .read<HomeCubit>()
                                          .returnButton(item),
                                      buttonLable: 'Remind me',
                                    ),
                                  );
                                });
                          },
                        );
                      });
                },
              ));
        },
      ),
    );
  }
}
