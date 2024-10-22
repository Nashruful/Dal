import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSubscriptionsCard extends StatelessWidget {
  final bool selected;
  final String duration;
  final double price;
  final String plan;
  final GestureTapCallback onTap;

  const CustomSubscriptionsCard(
      {super.key,
      required this.duration,
      required this.price,
      required this.plan,
      required this.selected,
      required this.onTap});

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
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffA51361),
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
                    color: Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: duration,
                    color: Color(0xff444444),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                CustomText(
                    text: '${price.toString()} SAR',
                    color: Color(0xff444444),
                    fontSize: 14)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          text: plan,
          color: Color(0xff444444),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        )
      ],
    );
  }
}
