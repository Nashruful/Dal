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
    return SizedBox(
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors().pink,
            child:
                IconButton(onPressed: onPressed, icon: SvgPicture.asset(icon)),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomText(
            text: title,
            color: AppColors().pink,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
