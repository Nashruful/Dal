import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  final supabase = getIt.get<DataLayer>().supabase;
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
  String firstName = getIt.get<DataLayer>().currentUserInfo!['first_name'];
  String lastName = getIt.get<DataLayer>().currentUserInfo!['last_name'];
  String email = getIt.get<DataLayer>().currentUserInfo!['email'];
  String image = getIt.get<DataLayer>().currentUserInfo!['profile_image'] ??
      'https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg';

  ThemeMode themeMode = ThemeMode.system;

  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    on<ProfileBlocEvent>((event, emit) {});

    //add or remove filter
    on<UpdateFilterEvent>((event, emit) {
      categories[event.category] = !categories[event.category]!;
      emit(UpdatedFilterState());
    });

    //change lang
    on<ChangeLangEvent>((event, emit) {
      langValue = event.value;

      emit(ChangedlangState());
    });

    // get user info
    on<GetInfoEvent>((event, emit) async {
      emit(LoadingState());
      await getIt.get<DataLayer>().getUserInfo();
      try {
        final info = getIt.get<DataLayer>().currentUserInfo;
        firstName = info!['first_name'];
        lastName = info['last_name'];
        email = info['email'];
        image = info['profile_image'];
        emit(GetInfoState(
            firstName: firstName,
            lastName: lastName,
            email: email,
            image: image));
      } on AuthException catch (e) {
        emit(ErrorState(msg: e.message));
        print(e.message);
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
        print(e.message);
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
