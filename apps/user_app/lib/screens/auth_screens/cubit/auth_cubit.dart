// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> response = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  AuthCubit() : super(AuthInitial());
  signUp() async {
    emit(LoadingState());
    try {
      response = await supabase
          .from("users")
          .select('email')
          .eq("email", emailController.text);
      if (response.isNotEmpty) {
        emit(ErrorState(msg: "Account Already registered."));
      } else {
        await supabase.auth.signInWithOtp(email: emailController.text, data: {
          "email": emailController.text,
        });
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

  signIn() async {
    emit(LoadingState());
    try {
      response = await supabase
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
      final Map<String, dynamic> isConfirmed =
          await supabase.from("users").select().eq("email", email).single();
      await supabase.auth.verifyOTP(
          type: isConfirmed['confirmed_at'] == null
              ? OtpType.signup
              : OtpType.magiclink,
          email: email,
          token: otp);

      if (isConfirmed['confirmed_at'] == null) {
        await supabase
            .from("users")
            .update({"confirmed_at": "2024-10-22 10:38:33.565971+00"}).eq(
                "email", email);
      }

      await OneSignal.login(supabase.auth.currentUser!.id);

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
