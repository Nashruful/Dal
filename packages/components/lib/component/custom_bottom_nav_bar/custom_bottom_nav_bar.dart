import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(
      {super.key,
      this.onTap,
      required this.icons1,
      required this.icons2,
      required this.icons3,
      required this.icons4,
      required this.label1,
      required this.label2,
      required this.label3,
      required this.label4,
      required this.index});
  final Function(int)? onTap;
  final String icons1;
  final String icons2;
  final String icons3;
  final String icons4;
  final String label1;
  final String label2;
  final String label3;
  final String label4;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).cardColor,
      selectedItemColor: AppColors().pink,
      unselectedItemColor: AppColors().grey2,
      unselectedLabelStyle: TextStyle(color: AppColors().grey2),
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(icons1,
              colorFilter: index == 0
                  ? ColorFilter.mode(AppColors().pink, BlendMode.srcIn)
                  : ColorFilter.mode(AppColors().grey2, BlendMode.srcIn)),
          label: label1,
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              icons2,
              colorFilter: index == 1
                  ? ColorFilter.mode(AppColors().pink, BlendMode.srcIn)
                  : ColorFilter.mode(AppColors().grey2, BlendMode.srcIn),
              width: 18,
            ),
            label: label2),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(icons3,
                colorFilter: index == 2
                    ? ColorFilter.mode(AppColors().pink, BlendMode.srcIn)
                    : ColorFilter.mode(AppColors().grey2, BlendMode.srcIn)),
            label: label3),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(icons4,
                colorFilter: index == 3
                    ? ColorFilter.mode(AppColors().pink, BlendMode.srcIn)
                    : ColorFilter.mode(AppColors().grey2, BlendMode.srcIn)),
            label: label4),
      ],
      onTap: onTap,
    );
  }
}
