import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdsContainer extends StatelessWidget {
  const CustomAdsContainer(
      {super.key,
      required this.ComapanyLogo,
      required this.remainingDay,
      required this.companyName,
      required this.offers, this.onTap});
  final String ComapanyLogo;
  final String remainingDay;
  final String companyName;
  final String offers;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 160,
        height: 230,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              blurStyle: BlurStyle.outer,
              blurRadius: 4,
              offset: const Offset(0, 2))
        ]),
        child: Stack(
          children: [
            Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(ComapanyLogo,fit: BoxFit.fill,)),
            ),
          
///
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 69,
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  border: Border.all(color: const Color(0xffB8B8B8)),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(11),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/clock.svg',
                      width: 24,
                    ),
                    const SizedBox(width: 3),
                    CustomText(
                      text: remainingDay,
                      color: const Color(0xffB8B8B8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: companyName,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff444444),
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: offers,
                      color: const Color(0xffA51361),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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