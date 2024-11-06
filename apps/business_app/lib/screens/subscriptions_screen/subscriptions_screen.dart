import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/screens/payment_screen/payment_confirmation_screen.dart';
import 'package:business_app/screens/subscriptions_screen/bloc/subscriptions_screen_bloc_bloc.dart';
import 'package:business_app/setup/setup.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => SubscriptionBloc(),
        child: Builder(builder: (context) {
          final bloc = context.read<SubscriptionBloc>();
          DateTime currentDate = DateTime.now();
          DateTime datePlus30Days = currentDate.add(const Duration(days: 30));
          final GlobalKey<FormState> formKey = GlobalKey<FormState>();
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const CustomAppBar(
                title: 'Subscription Plan', automaticallyImplyLeading: true),
            body: BlocListener<SubscriptionBloc, SubscriptionState>(
              listener: (context, state) {
                if (state is LoadingSubscriptionState) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Lottie.asset(
                              height: 30, 'assets/json/loading.json')));
                }
                if (state is SubscriptionConfirmedState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const Text('Successfully Activated Plan')));
                }
                if (state is ConfirmedState) {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                }
                if (state is SubscriptionErrorState) {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const CustemErrorDialog(msg: '');
                      });
                }
              },
              child: Form(
                key: formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: SvgPicture.asset(
                                            'assets/svg/Objective.svg'))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'title plan'.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text('sub title plan'.tr(),
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(
                                height: 15,
                              ),
                              BlocBuilder<SubscriptionBloc, SubscriptionState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomSubscriptionsCard(
                                        duration: 'Basic subscription'.tr(),
                                        price: 100,
                                        plan: 'Basic'.tr(),
                                        selected: bloc.selectedPlan[0]!,
                                        onTap: () {
                                          bloc.add(TabCardEvent(index: 0));
                                        },
                                        currency: 'SAR'.tr(),
                                      ),
                                      CustomSubscriptionsCard(
                                          duration: 'Premium Subscription'.tr(),
                                          price: 250,
                                          plan: 'Premium'.tr(),
                                          selected: bloc.selectedPlan[1]!,
                                          onTap: () {
                                            bloc.add(TabCardEvent(index: 1));
                                          },
                                          currency: 'SAR'.tr()),
                                      CustomSubscriptionsCard(
                                          duration:
                                              'Enterprise subscription'.tr(),
                                          price: 500,
                                          plan: 'Enterprise'.tr(),
                                          selected: bloc.selectedPlan[2]!,
                                          onTap: () {
                                            bloc.add(TabCardEvent(index: 2));
                                          },
                                          currency: 'SAR'.tr())
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              BlocBuilder<SubscriptionBloc, SubscriptionState>(
                                builder: (context, state) {
                                  return Text(bloc.planDesc,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).canvasColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        height: 300,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              bloc.planType,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            // ------------ change number -----------
                                            Text(
                                              bloc.planType == 'Basic'
                                                  ? 'Select exactly one branch'
                                                  : bloc.planType == 'Premium'
                                                      ? 'Select at most 5 branches'
                                                      : bloc.planType ==
                                                              'Enterprise'
                                                          ? 'Select unlimited branches'
                                                          : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            MultiDropdown(
                                              controller:
                                                  bloc.basicPlanController,
                                              singleSelect: false,
                                              enabled: true,
                                              maxSelections:
                                                  bloc.getBranchType(),
                                              searchEnabled: true,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              items:
                                                  bloc.branches.map((branch) {
                                                return DropdownItem(
                                                    label: branch['address']
                                                        .toString(),
                                                    value: bloc.branches
                                                        .indexOf(branch));
                                              }).toList(),
                                              onSelectionChange:
                                                  (selectedLocation) {
                                                bloc.selectedBranch.clear();
                                                for (var location
                                                    in selectedLocation) {
                                                  if (location <
                                                      bloc.branches.length) {
                                                    var branch =
                                                        bloc.branches[location];
                                                    bloc.selectedBranch
                                                        .add(branch['address']);
                                                  }
                                                }
                                              },
                                              fieldDecoration: FieldDecoration(
                                                  hintText: 'Select a branch',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .canvasColor),
                                              dropdownDecoration:
                                                  DropdownDecoration(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .canvasColor),
                                              dropdownItemDecoration:
                                                  DropdownItemDecoration(
                                                textColor: AppColors().grey2,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .canvasColor,
                                                selectedBackgroundColor:
                                                    AppColors().white1,
                                                selectedIcon: Icon(
                                                    Icons.check_box_outlined,
                                                    color: AppColors().pink),
                                              ),
                                              chipDecoration: ChipDecoration(
                                                  wrap: false,
                                                  backgroundColor:
                                                      AppColors().green),
                                              validator: (value) {
                                                if (bloc
                                                    .selectedBranch.isEmpty) {
                                                  return 'Please select a branch';
                                                }
                                                return null;
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ),
                                              child: CustomElevatedButton(
                                                onPressed: () {
                                                  //-------------- Payment -------------
                                                  if (formKey.currentState
                                                          ?.validate() ==
                                                      true) {
                                                    bloc.basicPlanController;
                                                    bloc.enterpriseController;
                                                    bloc.standardPlanController;
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PaymentConfirmationScreen(
                                                                  price: bloc
                                                                      .planPrice,
                                                                  type: bloc
                                                                      .planType,
                                                                  branch: bloc
                                                                      .selectedBranch,
                                                                )));
                                                  }
                                                },
                                                backgroundColor:
                                                    AppColors().pink,
                                                child: CustomText(
                                                  text: 'Confirm button'.tr(),
                                                  color: AppColors().white1,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  'choose Plan button'.tr(),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              !getIt.get<DataLayer>().currentBusinessInfo[0]
                                      ['free_trial']
                                  ? BlocBuilder<SubscriptionBloc,
                                      SubscriptionState>(
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: CustomElevatedButton(
                                            onPressed: !bloc.selectedPlan[0]!
                                                ? null
                                                : () {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .canvasColor,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                  )),
                                                          height: 300,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                bloc.planType,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headlineSmall,
                                                              ),
                                                              // ------------ change number -----------
                                                              Text(
                                                                bloc.planType ==
                                                                        'Basic'
                                                                    ? 'Select exactly one branch'
                                                                    : bloc.planType ==
                                                                            'Premium'
                                                                        ? 'select at most 5 branches'
                                                                        : bloc.planType ==
                                                                                'Enterprise'
                                                                            ? 'select unlimited branches'
                                                                            : '',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                              MultiDropdown(
                                                                controller: bloc
                                                                    .basicPlanController,
                                                                singleSelect:
                                                                    false,
                                                                enabled: true,
                                                                maxSelections: bloc
                                                                    .getBranchType(),
                                                                searchEnabled:
                                                                    true,
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                items: bloc
                                                                    .branches
                                                                    .map(
                                                                        (branch) {
                                                                  return DropdownItem(
                                                                      label: branch[
                                                                              'address']
                                                                          .toString(),
                                                                      value: bloc
                                                                          .branches
                                                                          .indexOf(
                                                                              branch));
                                                                }).toList(),
                                                                onSelectionChange:
                                                                    (selectedLocation) {
                                                                  bloc.selectedBranch
                                                                      .clear();
                                                                  for (var location
                                                                      in selectedLocation) {
                                                                    if (location <
                                                                        bloc.branches
                                                                            .length) {
                                                                      var branch =
                                                                          bloc.branches[
                                                                              location];
                                                                      bloc.selectedBranch.add(
                                                                          branch[
                                                                              'address']);
                                                                    }
                                                                  }
                                                                },
                                                                fieldDecoration: FieldDecoration(
                                                                    hintText:
                                                                        'Select a branch',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        borderSide:
                                                                            BorderSide
                                                                                .none),
                                                                    backgroundColor:
                                                                        Theme.of(context)
                                                                            .canvasColor),
                                                                dropdownDecoration:
                                                                    DropdownDecoration(
                                                                        backgroundColor:
                                                                            Theme.of(context).canvasColor),
                                                                dropdownItemDecoration:
                                                                    DropdownItemDecoration(
                                                                  textColor:
                                                                      AppColors()
                                                                          .grey2,
                                                                  backgroundColor:
                                                                      Theme.of(
                                                                              context)
                                                                          .canvasColor,
                                                                  selectedBackgroundColor:
                                                                      AppColors()
                                                                          .white1,
                                                                  selectedIcon: Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: AppColors()
                                                                          .pink),
                                                                ),
                                                                chipDecoration: ChipDecoration(
                                                                    wrap: false,
                                                                    backgroundColor:
                                                                        AppColors()
                                                                            .green),
                                                                validator:
                                                                    (value) {
                                                                  if (bloc
                                                                      .selectedBranch
                                                                      .isEmpty) {
                                                                    return 'Please select a branch';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                ),
                                                                child:
                                                                    CustomElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return CustemAlertDialog(
                                                                            title:
                                                                                'Activated Your Free Trial?',
                                                                            msg:
                                                                                'By confirming, your free ${bloc.planType} subscription will begin on ${currentDate.day}/${currentDate.month}/${currentDate.year} and last until ${datePlus30Days.day}/${datePlus30Days.month}/${datePlus30Days.year}.',
                                                                            onPressed:
                                                                                () {
                                                                              bloc.add(ConfirmSubscription(isFreeTrial: true, start: currentDate, end: datePlus30Days, price: 0, planType: 'Basic', selectedBranch: bloc.selectedBranch));
                                                                            },
                                                                            buttonLable:
                                                                                'Confirm button'.tr(),
                                                                            cancelLable:
                                                                                'Cancel Button'.tr(),
                                                                          );
                                                                        });
                                                                  },
                                                                  backgroundColor:
                                                                      AppColors()
                                                                          .pink,
                                                                  child:
                                                                      CustomText(
                                                                    text: 'Confirm button'
                                                                        .tr(),
                                                                    color: AppColors()
                                                                        .white1,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                            backgroundColor: AppColors().green,
                                            child: Text(
                                                'free Trial button'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium),
                                          ),
                                        );
                                      },
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
