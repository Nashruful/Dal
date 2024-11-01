import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStatee> {
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> response = [];
  late final String id;
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
        getIt.get<DataLayer>().businessId = response[0]['id'];
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
}
