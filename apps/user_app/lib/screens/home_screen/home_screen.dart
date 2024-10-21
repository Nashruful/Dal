import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA51361),
        foregroundColor: const Color(0xffF7F7F7),
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Image.asset(
                  'assets/png/Frame 65.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const CustomText(
                text: "Hello!",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xfff7f7f7),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/notification.svg'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Container(
              width: 341,
              height: 157,
              decoration: BoxDecoration(
                  color: const Color(0xffF6B00E),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Never miss out',
                              fontSize: 18,
                              color: Color(0xfff7f7f7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            width: 105,
                            child: CustomText(
                              text:
                                  'Catch the latest deals and offers happening near you!',
                              fontSize: 12,
                              color: Color(0xfff7f7f7),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Image.asset('assets/png/29-Influencer 1.png')
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomIconButton(
                  icon: 'assets/svg/coffee.svg',
                  title: 'Cafes',
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: 'assets/svg/Bakery.svg',
                  title: 'Bakery',
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: 'assets/svg/Breakfast.svg',
                  title: 'Breakfast',
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: 'assets/svg/Ice_creams.svg',
                  title: 'Ice creams',
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: 'assets/svg/Dinning.svg',
                  title: 'Dinning',
                  onPressed: () {},
                ),
                CustomIconButton(
                  icon: 'assets/svg/Drinks.svg',
                  title: 'Drinks',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const CustomText(
              text: 'Top',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff444444),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            const CustomText(
              text: 'Around you',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff444444),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                    CustomAdsContainer(
                        ComapanyLogo: 'assets/png/company_logo.png',
                        remainingDay: '4d',
                        companyName: 'Half Million',
                        offers: '50% Off'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
