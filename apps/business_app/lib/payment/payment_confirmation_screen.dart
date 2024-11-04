import 'package:business_app/screens/payment_screen/payment_screen.dart';
import 'package:business_app/screens/subscriptions_screen/bloc/subscriptions_screen_bloc_bloc.dart';
import 'package:components/component/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SubscriptionBloc>();
        DateTime currentDate = DateTime.now();
        DateTime datePlus30Days = currentDate.add(const Duration(days: 30));
        return Scaffold(
          appBar: const CustomAppBar(
              title: "Payment Confirmation", automaticallyImplyLeading: true),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Text(
                  "By confirming your payment, your ${bloc.planType} subscription will begin on ${currentDate.day}/${currentDate.month}/${currentDate.year} and last until ${datePlus30Days.day}/${datePlus30Days.month}/${datePlus30Days.year}.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 40,
                ),
                PaymentScreen(
                  totalPrice: bloc.planPrice,
                  planType: bloc.planType,
                  startDate: currentDate,
                  endDate: datePlus30Days,
                  paymentFunc: () {
                    bloc.add(ConfirmSubscription(
                        isFreeTrial: false,
                        start: currentDate,
                        end: datePlus30Days));
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
