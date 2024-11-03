
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key,
      required this.totalPrice,
      required this.planType,
      required this.startDate,
      required this.endDate,
      required this.paymentFunc});
  final double totalPrice;
  final String planType;
  final DateTime startDate;
  final DateTime endDate;
  final Function paymentFunc;
  paymentConfig() {
    return PaymentConfig(
      publishableApiKey:
          'pk_test_PB1baNgjCqvDmTbqdZQMCKXTWQejHLM7NUxwwRLV', //for now
      amount: (totalPrice * 100).toInt(),
      description: 'Subscription payment ',
      metadata: {},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        child: CreditCard(
          config: paymentConfig(),
          onPaymentResult: (PaymentResponse data) async {

            if (data.status.name == "paid") {
              paymentFunc();
            }
          },
        ),
      ),
    );
  }
}
