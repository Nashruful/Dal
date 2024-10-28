import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.icon, required this.title, this.onPressed});
  final String icon;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xffA51361),
          child: IconButton(onPressed: onPressed, icon: SvgPicture.asset(icon)),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomText(text: title, color: const Color(0xffA51361), fontSize: 10,)
      ],
    );
  }
}
