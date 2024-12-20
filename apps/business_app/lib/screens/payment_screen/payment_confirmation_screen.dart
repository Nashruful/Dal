import 'package:business_app/screens/payment_screen/payment_screen.dart';
import 'package:business_app/screens/subscriptions_screen/bloc/subscriptions_screen_bloc_bloc.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:components/component/custom_dialog/custom_erroe_msg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen(
      {super.key,
      required this.price,
      required this.type,
      required this.branch});
  final double price;
  final String type;
  final List branch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SubscriptionBloc>();
        DateTime currentDate = DateTime.now();
        DateTime datePlus30Days = currentDate.add(const Duration(days: 30));
        return Scaffold(
          appBar: CustomAppBar(
              title: "Payment Confirmation".tr(),
              automaticallyImplyLeading: true),
          body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
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
                    content: Text('Successfully Activated Plan'.tr())));
              }
              if (state is ConfirmedState) {
                Navigator.pop(context);
                Navigator.pop(context, true);
              }
              if (state is ErrorState) {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomErrorDialog(msg: state.msg);
                    });
              }
            },
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "payment confirmation message".tr(namedArgs: {
                          'planType': bloc.planType,
                          'currentDay': currentDate.day.toString(),
                          'currentMonth': currentDate.month.toString(),
                          'currentYear': currentDate.year.toString(),
                          'endDay': datePlus30Days.day.toString(),
                          'endMonth': datePlus30Days.month.toString(),
                          "endYear": datePlus30Days.year.toString()
                        }),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      PaymentScreen(
                        totalPrice: price,
                        planType: type,
                        startDate: currentDate,
                        endDate: datePlus30Days,
                        paymentFunc: () {
                          bloc.add(ConfirmSubscription(
                              isFreeTrial: false,
                              start: currentDate,
                              end: datePlus30Days,
                              price: price,
                              planType: type,
                              selectedBranch: branch));
                        },
                        errorFunc: () {
                          bloc.add(ErrorEvent());
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
