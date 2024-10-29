import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  //save it in storage
  Map<String, bool> categories = {
    'Cafe': true,
    'Breakfast': true,
    'Bakery': true,
    'Ice Creams': true,
    'Dinning': true,
    'Drinks': true
  };
  int langValue = 0;

  bool DarkModeOn = true;

  ThemeMode themeMode = ThemeMode.system;

  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    on<ProfileBlocEvent>((event, emit) {});

    //add or remove filter
    on<UpdateFilterEvent>((event, emit) {
      categories[event.category] = !categories[event.category]!;
      emit(UpdatedFilterState());
    });

    //change theme mode
    on<ChangeModeEvent>((
      event,
      emit,
    ) {
      DarkModeOn = !DarkModeOn;

      emit(ChangedModeState());
    });

    //change lang
    on<ChangeLangEvent>((event, emit) {
      langValue = event.value;

      emit(ChangedlangState());
    });
  }
}