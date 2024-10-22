import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_text/custom_text.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.image, required this.companyName, required this.iconImage, required this.description, required this.remainingDay});
  final String image;
  final String companyName;
  final String iconImage;
  final String description;
  final String remainingDay;

  @override
  Widget build(BuildContext context) {
    return Container(
                                height: 650,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 389,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.asset(
                                          image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: companyName,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: const Color(0xff444444),
                                              ),
                                              Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffA51361))),
                                                child: SvgPicture.asset(
                                                  iconImage,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Color(0xffA51361),
                                                          BlendMode.srcIn),
                                                  fit: BoxFit.values[6],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                           CustomText(
                                            text: description,
                                            color: const Color(0xff444444),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xff8CBFAE)),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/notification.svg'),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const CustomText(
                                                          text: 'Remind me ',
                                                          color:
                                                              Color(0xffF7F7F7),
                                                          fontSize: 14),
                                                    ],
                                                  )),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/svg/clock.svg'),
                                                   CustomText(
                                                      text: remainingDay,
                                                      color: const Color(0xffB8B8B8),
                                                      fontSize: 14)
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
  }
}