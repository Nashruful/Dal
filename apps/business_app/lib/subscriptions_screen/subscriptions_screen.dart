import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      
      return Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child:
                                SvgPicture.asset('assets/svg/Objectives.svg'))),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: 'Draw In Passing Customers!',
                      color: Color(0xff444444),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text:
                          'Make your business stand out! Attract passing customers with your best deals and invites by choosing one of the following subscription plans:',
                      color: Color(0xff444444),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSubscriptionsCard(
                          duration: '1 Month',
                          price: 100,
                          plan: 'Basic',
                          selected: true,
                          onTap: () {},
                        ),
                        CustomSubscriptionsCard(
                          duration: '1 Month',
                          price: 250,
                          plan: 'Premium',
                          selected: false,
                          onTap: () {},
                        ),
                        CustomSubscriptionsCard(
                          duration: '1 Month',
                          price: 500,
                          plan: 'Enterprise',
                          selected: false,
                          onTap: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text:
                          'Post your ads for passing customers for a month at a single business location, with access to basic ad stats.',
                      color: Color(0xff444444),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    1 == 1 //if used free plan
                        ? CustomElevatedButton(
                            onPressed: () {
                              //
                            },
                            backgroundColor: Color(0xff8CBFAE),
                            child: CustomText(
                              text: 'Free Trial',
                              color: Color(0xffF7F7F7),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : SizedBox(),
                    CustomElevatedButton(
                      onPressed: () {
                        //
                      },
                      backgroundColor: Color(0xffA51361),
                      child: CustomText(
                        text: 'Choose Plan',
                        color: Color(0xffF7F7F7),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
