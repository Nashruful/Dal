import 'package:components/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color(0xffA51361),
          foregroundColor: const Color(0xffF7F7F7),
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/png/company_logo.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 313,
                  height: 203,
                  decoration: BoxDecoration(
                      color: const Color(0xffF6B00E),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: 0,
                                child: CustomText(
                                  text: 'Never miss out',
                                  fontSize: 24,
                                  color: Color(0xfff7f7f7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Positioned(
                                bottom: 40,
                                child: SizedBox(
                                  width: 130,
                                  child: CustomText(
                                    text:
                                        'Catch the latest deals and offers happening near you!',
                                    fontSize: 14,
                                    color: Color(0xfff7f7f7),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Image.asset('assets/png/ads_banner_image.png')
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBusinessIconButton(
                          image: 'assets/svg/add_ads.svg', title: 'Add Ads'),
                      CustomBusinessIconButton(
                          image: 'assets/svg/view_stats.svg',
                          title: 'View Stats'),
                      CustomBusinessIconButton(
                          image: 'assets/svg/add_ads.svg', title: 'Add Ads'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBusinessIconButton(
                          image: 'assets/svg/add_ads.svg', title: 'Add Ads'),
                      CustomBusinessIconButton(
                          image: 'assets/svg/view_stats.svg',
                          title: 'View Stats'),
                      CustomBusinessIconButton(
                          image: 'assets/svg/add_ads.svg', title: 'Add Ads'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
