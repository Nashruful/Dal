import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdsContainer extends StatelessWidget {
  const CustomAdsContainer(
      {super.key,
      required this.companyLogo,
      required this.remainingDay,
      required this.companyName,
      required this.offers,
      this.onTap,
      this.opacity = 1});
  final String companyLogo;
  final String remainingDay;
  final String companyName;
  final String offers;
  final Function()? onTap;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          width: 160,
          height: 230,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ]),
          child: Stack(
            children: [
              Image.network(
                companyLogo,
                fit: BoxFit.contain,
                height: 200,
                opacity: AlwaysStoppedAnimation(opacity),
              ),
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
                        topRight: Radius.circular(11)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/clock.svg',
                        width: 23,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        remainingDay,
                        style: TextStyle(color: AppColors().grey2),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offers,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
