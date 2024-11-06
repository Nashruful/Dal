import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  final supabase = getIt.get<DataLayer>().supabase;
  List businessInfo = getIt.get<DataLayer>().currentBusinessInfo;
  Map plan = getIt.get<DataLayer>().latestSubscription;

  String planEndDate =
      getIt.get<DataLayer>().latestSubscription['end_date'] ?? '';
  DateTime currentDate = DateTime.now();
  int langValue = 0;

  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    langValue = getIt.get<DataLayer>().box.read('language') ?? 0;
    on<ProfileBlocEvent>((event, emit) {});

    //change language
    on<ChangeLangEvent>((event, emit) {
      langValue = event.value;
      getIt.get<DataLayer>().box.write('language', langValue);
      emit(ChangedlangState());
    });

    //Refresh
    on<RefreshScreenEvent>((event, emit) async {
      await getIt.get<DataLayer>().getBusinessInfo();
      businessInfo = getIt.get<DataLayer>().currentBusinessInfo;
      plan = getIt.get<DataLayer>().latestSubscription;
      planEndDate = getIt.get<DataLayer>().latestSubscription['end_date'] ?? '';
      emit(SuccessState());
    });
  }

  String getPlanType(Map currentPlan) {
    final String planType;
    if (plan['subscription_type'] == 'Basic') {
      return 'Basic';
    } else if (plan['subscription_type'] == 'Premium') {
      return 'Premium';
    } else if (plan['subscription_type'] == 'Enterprise') {
      return 'Enterprise';
    } else {
      planType = 'No Subscription';
    }

    return planType;
  }

  String getPlanDesc(Map currentPlan) {
    final String planDesc;
    if (plan['subscription_type'] == 'Basic') {
      planDesc = 'Basic description'.tr();
    } else if (plan['subscription_type'] == 'Premium') {
      planDesc = 'Premium description'.tr();
    } else if (plan['subscription_type'] == 'Enterprise') {
      planDesc = 'Enterprise description'.tr();
    } else {
      planDesc = 'No Data';
    }

    return planDesc;
  }

  int getRemainingDays(DateTime planEndDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = planEndDate.difference(currentDate);

    int days = difference.inDays;

    if (days < 0) {
      days = 0;
    }
    return days;
  }
}
