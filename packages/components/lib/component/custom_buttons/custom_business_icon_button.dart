import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_text/custom_text.dart';

class CustomBusinessIconButton extends StatelessWidget {
  const CustomBusinessIconButton(
      {super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 85,
          width: 87,
          decoration: BoxDecoration(
              color: const Color(0xffA51361),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 152, 151, 151)
                        .withOpacity(0.25),
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(0, 2))
              ]),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              image,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomText(
          text: title,
          color: const Color(0xffA51361),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
