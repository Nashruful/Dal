import 'package:bloc/bloc.dart';
import 'package:business_app/data_layer/data_layer.dart';
import 'package:business_app/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  String businessName = '';
  String email = '';
  String image = '';


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
            .from('business')
            .select()
            .eq('id', supabase.auth.currentUser!.id)
            .single();
        businessName = info['name'];
        email = info['email'];
        image = info['logo_img'];
        emit(GetInfoState(
          name: businessName, email: email, image: image));
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
          .from('business')
          .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
        add(GetInfoEvent());
      });
    }

    getInfoRealTime();
  }
}