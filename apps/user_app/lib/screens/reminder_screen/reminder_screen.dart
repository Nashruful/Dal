import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_containers/reminders_ads_container.dart';
import 'package:components/component/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:user_app/screens/home_screen/cubit/home_cubit.dart';
import 'package:user_app/screens/reminder_screen/bloc/reminder_event.dart';
import 'package:user_app/screens/reminder_screen/bloc/reminder_state.dart';
import 'package:user_app/screens/reminder_screen/bloc/reminedr_bloc.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blockContext) => ReminderBloc(),
      child: Builder(builder: (blockContext) {
        blockContext.read<ReminderBloc>().add(LoadReminders());
        return Scaffold(
          appBar: CustomAppBar(
              title: 'My Reminders', automaticallyImplyLeading: false),
          body: BlocBuilder<ReminderBloc, ReminderState>(
            builder: (context, state) {
              if (state is ReminderLoading) {
                return Center(
                    child: Lottie.asset('assets/json/loading.json', width: 30));
              } else if (state is ReminderLoaded) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: state.myReminders.length,
                  itemBuilder: (context, index) {
                    final item = state.myReminders[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RemindersAdsContainer(
                        companyLogo: item['bannerimg'] ??
                            "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg",
                        remainingDay: '4d',
                        companyName: item['title'] ?? "----",
                        offers: item['offer_type'],
                        onTap: () {
                          return showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 650,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      height: 389,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.network(
                                          item['bannerimg'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '40',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/discover.svg',
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                BlendMode
                                                                    .srcIn),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "view Location",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          Text(
                                            item['title'] ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            item['description'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    blockContext
                                                        .read<ReminderBloc>()
                                                        .add(RemoveReminder(
                                                            item));
                                                    Navigator.pop(context);
                                                    blockContext
                                                        .read<ReminderBloc>()
                                                        .add(LoadReminders());
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xffA51361)),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/no_notification.svg'),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'Remove reminder',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                    ],
                                                  )),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/svg/clock.svg'),
                                                  Text('4d',
                                                      style: TextStyle(
                                                          color: AppColors()
                                                              .grey2)),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffA51361))),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/coffee.svg',
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              Color(
                                                                  0xff7f7f7f7),
                                                              BlendMode.srcIn),
                                                      fit: BoxFit.values[6],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (state is ReminderNoData) {
                return Center(child: Text('No data'));
              } else {
                return Center(child: Text('Failed to load data'));
              }
            },
          ),
        );
      }),
    );
  }
}
