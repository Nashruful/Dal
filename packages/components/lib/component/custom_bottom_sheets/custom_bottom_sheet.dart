import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key,
      required this.image,
      required this.companyName,
      required this.iconImage,
      required this.description,
      required this.remainingDay,
      required this.offerType,
         required this.remindBtnText,
      required this.isReminder,
      this.onPressed,
      required this.viewLocation,
      this.locationOnPressed});
  final String image;
  final String companyName;
  final String offerType;
  final String iconImage;
  final String description;
  final String remainingDay;
  final String viewLocation;
  final void Function()? onPressed;
  final void Function()? locationOnPressed;
  final bool isReminder;
  final String remindBtnText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 389,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      offerType,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(
                        onPressed: locationOnPressed,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/discover.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).primaryColor,
                                  BlendMode.srcIn),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              viewLocation,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ))
                  ],
                ),
                Text(
                  companyName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                           backgroundColor:isReminder?   const Color(0xff8CBFAE):const Color(0xffA51361)),
                        child: Row(
                          children: [
                            
                       isReminder?     SvgPicture.asset('assets/svg/notification.svg'): SvgPicture.asset('assets/svg/no_notification.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Remind me ',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        )),
                    Row(
                      children: [
                        SvgPicture.asset('assets/svg/clock.svg'),
                        Text(remainingDay,
                            style: TextStyle(color: AppColors().grey2)),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                              border:
                                  Border.all(color: const Color(0xffA51361))),
                          child: SvgPicture.asset(
                            iconImage,
                            colorFilter: const ColorFilter.mode(
                                Color(0xff7f7f7f7), BlendMode.srcIn),
                            fit: BoxFit.values[6],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
