import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_app/screens/auth_screens/cubit/auth_cubit.dart';
import 'package:pinput/pinput.dart';
import 'package:user_app/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';

class VerifyScreen extends StatelessWidget {
  final String? email;
  const VerifyScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthStatee>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: CircularProgressIndicator()));
            }
            if (state is SuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBarScreen()));
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: SizedBox(
                          height: 100, width: 100, child: Text(state.msg))));
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Form(
              key: cubit.formKey,
              child: Stack(
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Verify title",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge)
                              .tr(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: "Verify subtitle".tr(),
                                  style: const TextStyle(
                                      color: Color(0xff444444), fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: "\n$email",
                                    style: const TextStyle(
                                        color: Color(0xff8CBFAE), fontSize: 16))
                              ])),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Confirmation code",
                                  style: Theme.of(context).textTheme.bodyMedium)
                              .tr(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Pinput(
                          controller: cubit.otpController,
                          length: 6,
                          onCompleted: (value) {
                            cubit.verifyOTP(
                                otp: cubit.otpController.text, email: email!);
                          },
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        CustomElevatedButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {}
                            },
                            backgroundColor: const Color(0xffA51361),
                            child: Text("Verify",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                .tr()),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text("Resend OTP",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                .tr())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
