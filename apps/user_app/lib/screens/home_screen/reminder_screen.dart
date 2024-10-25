import 'package:components/component/custom_containers/custom_ads_container.dart';
import 'package:components/component/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA51361),
        foregroundColor: const Color(0xffF7F7F7),
        centerTitle: true,
        title: const CustomText(
          text: "My Reminder",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xfff7f7f7),
        ),
      ),
      body:   Padding(
        padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, 
               crossAxisSpacing: 16, 
              mainAxisSpacing: 16, 
              childAspectRatio:
                  2 / 3, 
            ),
            itemCount:
                6, 
            itemBuilder: (context, index) {
              return CustomAdsContainer(ComapanyLogo:'assets/png/company_logo.png', remainingDay: '4d', companyName: 'half millon', offers: '05 %off ', ); 
            },
          ),
      ),
         
           
            );
   
  }
}