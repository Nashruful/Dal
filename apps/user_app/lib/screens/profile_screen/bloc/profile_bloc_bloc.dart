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

  String firstName = '';
  String lastName = '';
  String email = '';
  String image = '';

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
      try {
        final info = await supabase
            .from('users')
            .select()
            .eq('id', supabase.auth.currentUser!.id)
            .single();
        firstName = info['first_name'];
        lastName = info['last_name'];
        email = info['email'];
        image = info['profile_image'];
        emit(GetInfoState(
            firstName: firstName, lastName: lastName, email: email, image: image));
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

    // listen to users table
    void getInfoRealTime() {
      supabase
          .from('users')
          .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
        add(GetInfoEvent());
      });
    }

    getInfoRealTime();
  }
}
