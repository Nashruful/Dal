import 'package:business_app/screens/auth_screens/login_screen.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: SvgPicture.asset("assets/svg/onboarding_lady.svg")),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(" Catch Eyes, Get Noticed!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge),
                      SizedBox(
                        height: 9,
                      ),
                      Text(
                          "Experience a fresh way to grab the attention of passersby and significantly boost your visibility. Transform how you advertise and connect with potential customers effortlessly!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
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
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
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
