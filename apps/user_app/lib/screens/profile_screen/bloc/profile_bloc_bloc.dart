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
  Map<String, dynamic> categories = getIt.get<DataLayer>().categories;
  int langValue = 0;
  String firstName =
      getIt.get<DataLayer>().currentUserInfo!['first_name'] ?? '';
  String lastName = getIt.get<DataLayer>().currentUserInfo!['last_name'] ?? '';
  String email = getIt.get<DataLayer>().currentUserInfo!['email'] ?? '';
  String image = getIt.get<DataLayer>().currentUserInfo!['profile_image'] ??
      'https://axzkcivwmekelxlqpxvx.supabase.co/storage/v1/object/public/user%20profile%20images/images/defualt_profile_img.png?t=2024-11-03T13%3A11%3A13.024Z';

  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    langValue = getIt.get<DataLayer>().box.read('language') ?? 0;
    on<ProfileBlocEvent>((event, emit) {});

    //add or remove filter
    on<UpdateFilterEvent>((event, emit) {
      categories[event.category] = !categories[event.category]!;
      emit(UpdatedFilterState());
      getIt.get<DataLayer>().saveCategories();
    });

    //change lang
    on<ChangeLangEvent>((event, emit) {
      langValue = event.value;
      
      getIt.get<DataLayer>().box.write('language', langValue);
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
      } on PostgrestException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
