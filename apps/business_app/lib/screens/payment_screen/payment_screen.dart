import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key,
      required this.totalPrice,
      required this.planType,
      required this.startDate,
      required this.endDate,
      required this.paymentFunc, required this.errorFunc});
  final double totalPrice;
  final String planType;
  final DateTime startDate;
  final DateTime endDate;
  final Function paymentFunc;
  final Function errorFunc;
  paymentConfig() {
    return PaymentConfig(
      publishableApiKey:
          dotenv.env["PAYMENT_API_KEY"].toString(), //for now // *****.env******
      amount: (totalPrice * 100).toInt(),
      description: 'Subscription payment ',
      metadata: {},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CreditCard(
      config: paymentConfig(),
      onPaymentResult: (PaymentResponse data) async {
        if (data.status.name == "paid") {
          paymentFunc();
        }
        errorFunc();
      },
    );
  }
}
