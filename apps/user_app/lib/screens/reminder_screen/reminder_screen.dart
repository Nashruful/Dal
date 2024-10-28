import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_containers/reminders_ads_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Reminders".tr(),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2 / 3,
        ),
        itemCount: getIt.get<DataLayer>().myReminders.length,
        itemBuilder: (context, index) {
          final item = getIt.get<DataLayer>().myReminders;

          return Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RemindersAdsContainer(
              companyLogo: item[index]['bannerimg'],
              remainingDay: '4d',
              companyName: item[index]['title'],
              offers: '${item[index]['offer_type']} ${'off'.tr()}',
            ),
          );
        },
      ),
    );
  }
}
