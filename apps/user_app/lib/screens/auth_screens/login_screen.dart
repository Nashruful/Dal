import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-191, 0),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(19.74 / 360),
                child: Container(
                  height: 326,
                  width: 346.53,
                  decoration: BoxDecoration(
                      color: const Color(0x80F6EFDE),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-40, 110),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-32.12 / 360),
                child: Container(
                  height: 249.17,
                  width: 247.82,
                  decoration: BoxDecoration(
                      color: const Color(0x20D9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(30, 40),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-62.61 / 360),
                child: Container(
                  height: 95.17,
                  width: 106.34,
                  decoration: BoxDecoration(
                      color: const Color(0x20D9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(85, -160),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-39.05 / 360),
                child: Container(
                  height: 114.87,
                  width: 114.99,
                  decoration: BoxDecoration(
                      color: const Color(0x80FCECF4),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-118, 0),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-39.05 / 360),
                child: Container(
                  height: 190.68,
                  width: 169.29,
                  decoration: BoxDecoration(
                      color: const Color(0x20D9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-150, 120),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-17.06 / 360),
                child: Container(
                  height: 190.68,
                  width: 189.89,
                  decoration: BoxDecoration(
                      color: const Color(0x80F6EFDE),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: const Offset(120, 80),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-45.46 / 360),
                child: Container(
                  height: 190.68,
                  width: 195.79,
                  decoration: BoxDecoration(
                      color: const Color(0x20D9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SvgPicture.asset("assets/svg/Dal_logo.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: "Login", color: Color(0xff444444), fontSize: 32),
                ),
                const SizedBox(
                  height: 48,
                ),
                const CustomTextFormField(
                  hintStyle: TextStyle(color: Color(0x80000000)),
                  labelText: "Email",
                  hintText: "Enter your email",
                  fillColor: Color(0xffEAEAEA),
                ),
                const SizedBox(
                  height: 45,
                ),
                CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: const Color(0xffA51361),
                    child: const CustomText(
                        text: "Login", color: Color(0xffF7F7F7), fontSize: 14)),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {},
                    child: const CustomText(
                        text: "Create An Account",
                        color: Color(0xff444444),
                        fontSize: 14))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
