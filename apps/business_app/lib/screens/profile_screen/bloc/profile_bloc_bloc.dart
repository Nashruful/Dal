import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
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
    on<ProfileBlocEvent>((event, emit) {});

    //change language
    on<ChangeLangEvent>((event, emit) {
      langValue = event.value;

      emit(ChangedlangState());
    });

    //Refresh
    on<RefreshScreenEvent>((event, emit) async {
      print('refresh event');
      await getIt.get<DataLayer>().getBusinessInfo();
      businessInfo = getIt.get<DataLayer>().currentBusinessInfo;
      plan = getIt.get<DataLayer>().latestSubscription;
      emit(SuccessState());
    });
  }
}
