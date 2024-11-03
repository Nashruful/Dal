import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSubscriptionsCard extends StatelessWidget {
  final bool selected;
  final String duration;
  final double price;
  final String plan;
  final String currency;
  final GestureTapCallback onTap;

  const CustomSubscriptionsCard(
      {super.key,
      required this.duration,
      required this.price,
      required this.plan,
      required this.selected,
      required this.onTap,
      required this.currency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 105,
            width: 105,
            decoration: selected
                ? BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors().pink,
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  )
                : BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors().black1.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(duration, style: Theme.of(context).textTheme.bodyMedium),
                Text('${price.toString()} $currency',
                    style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          plan,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
