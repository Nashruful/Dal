import 'package:components/components.dart';
import 'package:flutter/material.dart';

class PastAdsTab extends StatelessWidget {
  const PastAdsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CustomText(
        text: "No past ads available",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
         ),
    );
  }
}