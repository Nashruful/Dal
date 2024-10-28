import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_app/screens/auth_screens/create_account_screen.dart';
import 'package:user_app/screens/auth_screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SvgPicture.asset("assets/svg/36-Teenager 1.svg"),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Text("Onboarding title",
                            style: Theme.of(context).textTheme.headlineLarge)
                        .tr(),
                    SizedBox(
                      height: 9,
                    ),
                    Text("Onbording subtitle".tr(),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      backgroundColor: const Color(0xffA51361),
                      child: Text("Login",
                              style: Theme.of(context).textTheme.titleMedium)
                          .tr(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                        onPressed: () {
                          print(EasyLocalization.of(context)!.currentLocale);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateAccountScreen()));
                        },
                        child: Text("Or create an account".tr(),
                            style: Theme.of(context).textTheme.bodyMedium))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
