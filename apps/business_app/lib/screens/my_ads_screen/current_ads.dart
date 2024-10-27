///////
///
import 'package:components/components.dart';
import 'package:flutter/material.dart';
///

class CurrentAdsTap extends StatelessWidget {
  const CurrentAdsTap({super.key});
  
  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 600 ? 3 : 2; 

    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2 / 3,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return CustomAdsContainer(
            companyName: 'Half Million',
            companyLogo: 'assets/png/company_logo.png',
            remainingDay: '4d',
            offers: '50% off',
          );
        },
      ),
    );
 
  }
}