import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key,
      required this.image,
      required this.companyName,
      this.iconImage,
      required this.description,
      required this.remainingDay,
      required this.offerType,
      this.onPressed,
      required this.button,
      this.views,
      this.clicks,
      this.textButton});
  final String image;
  final String companyName;
  final String offerType;
  final String? iconImage;
  final String description;
  final String remainingDay;
  final void Function()? onPressed;
  final ElevatedButton button;
  final int? views;
  final int? clicks;
  final TextButton? textButton;

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
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                    textButton ?? const SizedBox.shrink(),
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
                    button,
                    views == null
                        ? Row(
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
                                    border: Border.all(
                                        color:AppColors().pink)),child: SvgPicture.asset(iconImage!),

                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye_outlined,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(views.toString())
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.ads_click,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(clicks.toString())
                                ],
                              )
                            ],
                          )
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
