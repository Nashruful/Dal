import 'package:components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
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
                  builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset('assets/json/loading.json',
                          width: 30)));
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
                  builder: (context) {
                    return CustemErrorDialog(msg: (state.msg));
                  });
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Form(
              key: cubit.formKey,
              child: Stack(
                children: [
                  CustomBackground(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Verify title",
                                style:
                                    Theme.of(context).textTheme.headlineLarge)
                            .tr(),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Verify subtitle".tr(),
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                              TextSpan(
                                  text: "\n$email",
                                  style: TextStyle(color: AppColors().green))
                            ])),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Confirmation code",
                                style: Theme.of(context).textTheme.bodyMedium)
                            .tr(),
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
                          focusedPinTheme: PinTheme(
                              height: 55,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors().green, width: 2))),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        CustomElevatedButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {}
                            },
                            backgroundColor: AppColors().pink,
                            child: Text("Verify",
                                    style:
                                        Theme.of(context).textTheme.labelMedium)
                                .tr()),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {},
                              child: Text("Resend OTP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)
                                  .tr()),
                        )
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
