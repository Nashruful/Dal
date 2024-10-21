import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  final supabase = getIt.get<DataLayer>().supabase;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  AuthCubit() : super(AuthInitial());
  signUp() async {
    emit(LoadingState());
    try {
      final response = await supabase
          .from("users")
          .select()
          .eq("email", emailController.text);
      if (response.isNotEmpty) {
        emit(ErrorState(msg: "Account Already registered."));
      } else {
        await supabase.auth.signInWithOtp(email: emailController.text);
        emit(SuccessState());
      }
    } on AuthException catch (e) {
      emit(ErrorState(msg: e.message));
    } on PostgrestException catch (_) {
      emit(ErrorState(msg: "Account already registered"));
    } catch (e) {
      emit(ErrorState(msg: e.toString()));
    }
  }
  signIn() async {
    emit(LoadingState());
    try {
      final response = await supabase
          .from("users")
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
      await supabase.auth
          .verifyOTP(type: OtpType.magiclink, email: email, token: otp);

      await OneSignal.login(supabase.auth.currentUser!.id);

     

      await getIt.get<DataLayer>().getUserInfo();

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

  firstTimeVerifyOTP(
      {required String otp,
      required String email,
     }) async {
    emit(LoadingState());
    try {
      final data = await supabase.auth
          .verifyOTP(type: OtpType.signup, email: email, token: otp);

      await supabase.from("users").insert({
        
        "email": email,
        "external_id": data.user?.id
      });

      OneSignal.login(supabase.auth.currentUser!.id);

      await getIt.get<DataLayer>().getUserInfo();

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
