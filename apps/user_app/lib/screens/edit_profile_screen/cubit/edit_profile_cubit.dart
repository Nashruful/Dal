import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_app/data_layer/data_layer.dart';
import 'package:user_app/setup/setup.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  final supabase = getIt.get<DataLayer>().supabase;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  ImagePicker pick = ImagePicker();
  File? image;

  Future<void> pickAdsImage() async {
    final XFile? imageFile = await pick.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      image = File(imageFile.path);
      emit(AdsImageState(image: File(imageFile.path)));
    }
  }

  Future<void> changeName(String firstName, String lastName) async {
    try {
      emit(LoadingState());
      await supabase.from('users').update({
        'first_name': firstName,
        'last_name': lastName
      }).eq('id', supabase.auth.currentUser!.id);
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
