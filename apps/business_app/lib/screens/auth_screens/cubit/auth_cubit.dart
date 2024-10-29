import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> response = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  AuthCubit() : super(AuthInitial());

  signIn() async {
    emit(LoadingState());
    print("------------ Start");
    try {
      response = await supabase
          .from("business")
          .select()
          .eq("email", loginController.text);

      if (response.isEmpty) {
        emit(ErrorState(msg: "Account not found."));
      } else {
        await supabase.auth.signInWithOtp(email: loginController.text);

        emit(SuccessState());
      }
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  verifyOTP({required String otp, required String email}) async {
    emit(LoadingState());
    try {
      final Map<String, dynamic> isConfirmed =
          await supabase.from("business").select().eq("email", email).single();
      await supabase.auth.verifyOTP(
          type:
              //  isConfirmed['confirmed_at'] == null
              //     ? OtpType.signup
              //     :
              OtpType.magiclink,
          email: email,
          token: otp);

      // if (isConfirmed['confirmed_at'] == null) {
      //   await supabase
      //       .from("users")
      //       .update({"confirmed_at": "2024-10-22 10:38:33.565971+00"}).eq(
      //           "email", email);
      // }

      // await OneSignal.login(supabase.auth.currentUser!.id); ---- Later when connecting with OneSignal

      await getIt.get<DataLayer>().getBusinessInfo();

      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
      print(e.message);
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
      print(e.message);
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }

  firstTimeVerifyOTP({
    required String otp,
    required String email,
  }) async {
    emit(LoadingState());
    try {
      final data = await supabase.auth
          .verifyOTP(type: OtpType.signup, email: email, token: otp);

      await supabase
          .from("business")
          .insert({"email": email, "external_id": data.user?.id});

      OneSignal.login(supabase.auth.currentUser!.id);

      await getIt.get<DataLayer>().getBusinessInfo();

      emit(SuccessState());
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (e) {
      emit(ErrorState(msg: e.message));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
}
